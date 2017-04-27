require 'nokogiri'
require 'open-uri'
require 'json'

class PeerTeacherController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :new, :create, :edit, :update]
  skip_before_action :after_sign_in_path_for
  helper_method :sign_user_off
  
  def sign_user_off 
    if user_signed_in?
      destroy_user_session_path
    end
  end
  

  def func n
    return n
  end
    
  def index
    #session[:available_pts].clear
    @time = Time.new
    if user_signed_in?
      sign_out current_user
    end
    @peer_teachers = PeerTeacher.all
    @office_hours = OfficeHour.all
    #populate_db
    availables
    @updates = Update.all
    
    # Mail.deliver do
    # to 'justing169589@gmail.com'
    # from 'justafakemeail@gmail.com'
    # subject 'testing sendmail'
    # body 'testing sendmail'
    # end
    
    # def index
    #     @posts = Post.all
    #     if params[:search]
    #         @posts = Post.search(params[:search]).order("created_at DESC")
    #     else
    #         @posts = Post.all.order('created_at DESC')
    #     end
    # end
    
  end
  
  def populate_db
    PeerTeacher.delete_all
    OfficeHour.delete_all
    
    Rails.logger.info("Db Updated at #{Time.now}")
    
    url = 'https://engineering.tamu.edu/cse/academics/peer-teachers/current-peer-teachers'
    html = open(url)
    doc = Nokogiri::HTML(html)
    timeid = 100
    @tag_separator = ' -'
    
    people = []
    sched = []
    allhours = []
    copyhours = []
    time = []
     
    #for class record
    doc.css('.record').each do |record|
      imageURLlist = record.css('img').map{ |i| i['src'] }
      if(imageURLlist[0])
        imageURL = "https://engineering.tamu.edu" + imageURLlist[0]
      end
      name_el = record.css('h3')  
      name = name_el.text.strip 
      emailList = record.css('h4 a').map { |i| i['href']}
      newEmail = emailList[0]
      if(newEmail)
        newEmail = newEmail.split(/mailto:/)
        email = newEmail[1]
      end
      allcourses = record.css('li').map { |course| course.text.strip.split(/(\d+)/) } 
      allcourses = allcourses.map { |v| v[1] }
      courses = ''
      if(allcourses)
        for j in 0..allcourses.size
          if(allcourses[j])
            if (j != (allcourses.size - 1))
              courses += allcourses[j] + ", "
            else
              courses += allcourses[j]
            end
          end
        end
      end
      timeList = ''

      #check for null here there's an empty person at the end, but this is maybe just nitpicking at this point
      sched = record.css('td').map { |days| days.text.strip } 
        
      while sched.any?
        officehours = sched.shift(2)
        days = officehours[0].split(/(M|T|W|R|F|SU)/)
        days.delete("")
        #puts "officehours #{officehours}"
      
        sh = []
        sm = []
        eh = []
        em = []
      
        tmp = officehours[1].split("-").map{|time| time.strip!.delete(":")}
        if tmp[0].include? "am"
          tmp[0].delete!("am").strip!
        elsif tmp[0].include? "pm"
          tmp[0].delete!("pm").strip!
          tmp[0] = tmp[0].to_i > 1200 ? tmp[0] : (tmp[0].to_i + 1200).to_s
        else 
          if tmp[1].include? "pm"
            tmp[1].delete!("pm").strip!
            tmp[0] = tmp[0].to_i > 1200 ? tmp[0] : (tmp[0].to_i + 1200).to_s
            tmp[1] = tmp[1].to_i > 1200 ? tmp[1] : (tmp[1].to_i + 1200).to_s
          end # inner if
          
          if tmp[1].include? "am"
            tmp[1].delete!("am").strip!
          end # inner if
        end # else
        
        if tmp[1].include? "pm"
          tmp[1].delete!("pm").strip!
          tmp[1] = tmp[1].to_i > 1200 ? tmp[1] : (tmp[1].to_i + 1200).to_s
        end # if
            
        sh = tmp[0][0..-3]
        sm = tmp[0][-2..-1]
        eh = tmp[1][0..-3]
        em = tmp[1][-2..-1]
        
        if (sh == '24')
          sh = '12'
        end # if
        if(eh == '24')
          eh = '12'
        end # if
        
        days.each do |d| 
          OfficeHour.create(:timeID => timeid, :email => email, :dow => d, :sHour => sh, :sMin => sm, :eHour => eh, :eMin => em, :change => "No Change")
        end # days
        timeid += 1
        timeList += timeid.to_s + ','
        
        times = [sh, sm, eh, em]
        hrs = days.map{|d| [d] + times }
        copyhours = copyhours + hrs
      end #while
      
      allhours = copyhours[0,copyhours.length]
      
      copyhours.clear
    
      if(name != '')
        PeerTeacher.create(:email => email, :name => name, :courselist => courses, :timelist => timeList, :image => imageURL)
        nameArray = name.split( ' ' )   #split the name by space to enter into User model 
        
        if User.find_by_email( email ).nil? && !email.nil?  #or !email.empty? or !email.blank?
          PeerTeacherLogin.create(:first_name => nameArray[ 0 ], :last_name => nameArray[ 1 ], :image => imageURL, :user_attributes => { :email => email, :password => 'peerteacher', :password_confirmation => "peerteacher"} )
        end
        
      end
    end
    redirect_to :back
  end
  
  def availables
    @time = Time.new
    centralHour = @time.hour - 5
    correctedDay = @time.wday
    correctedDate = @time.day
    if(centralHour < 0)
      centralHour += 24
      correctedDay -= 1
      correctedDate -= 1
    end
    
    today = (@time.month.to_s + "/" + correctedDate.to_s + "/" + @time.year.to_s)
    
    if(session[:available_pts])   #.size > 0s
      session[:available_pts].clear
    else
      session[:available_pts] = Array.new
    end
    
    @office_hours = OfficeHour.all
    @peer_teachers = PeerTeacher.all
    
    #For testing
    #session[:available_pts].push("amanda.bsaibes@tamu.edu")
    #session[:available_pts].push("cangkevin@tamu.edu")
    #Update.delete_all #MAKE SURE TO COMMENT THIS WHEN DONE WITH TESTING
    #@office_hours.where(email: "josiah@coad.net").find_each do |kevinTime|
    #  if(kevinTime.dow == "R")
    #    kevinTime.update(change: "Delete")
    #    Update.create(:timeID => kevinTime.timeID, :email => kevinTime.email, :dow => "", :sHour => "", :sMin => "", :eHour => "", :eMin => "", :date => "3/30/2017", :action => "Delete", :msg => "I have a job interview at the same time, so I cannot attend my office hours today.", :approved => 1)
    #  end
    #end
    
    #@office_hours.where(email: "tcarlson25@tamu.edu").find_each do |tylerTime|
      #if(tylerTime.dow == "")
     #   tylerTime.update(change: "3/28/2017")
      #  Update.create(:timeID => tylerTime.timeID, :email => tylerTime.email, :dow => "T", :sHour => 16, :sMin => 40, :eHour => 18, :eMin => 56, :date => "3/26/2017", :action => "Add", :msg => "TEST 2", :approved => 1)
      #end
    #end
    
    @updates = Update.all

    @updates.each do |oh|
      if(oh.action == "Add" && oh.date == today && oh.approved = 1)
        if(oh.dow == "M")
          if(correctedDay != 1)
            next
          end
        end
        if(oh.dow == "T")
          if(correctedDay != 2)
            next
          end
        end
        if(oh.dow == "W")
          if(correctedDay != 3)
            next
          end
        end
        if(oh.dow == "R")
          if(correctedDay != 4)
            next
          end
        end
        if(oh.dow == "F")
          session[:dest] = "Friday"
          if(correctedDay != 5)
            next
          end
        end
        if(oh.dow == "Su")
          if(correctedDay != 0)
            next
          end
        end
        
        if (oh.sHour > centralHour || oh.eHour < centralHour)
          next
        end
        
        if(oh.sHour == centralHour)
          if(oh.sMin > @time.min)
            next
          end
        end

        if(oh.eHour == centralHour)
          if(oh.eMin < @time.min)
            orig = @office_hours.find_by(timeID: oh.timeID)
            if(orig)
              orig.update(change: "No Change")
            end
            oh.destroy
            next
          end
        end
        
        session[:available_pts].push(oh.email)
      elsif(oh.approved == 0)
        oh.destroy
      end
    end
    
    @office_hours.each do |oh|
      if(oh.dow == "M")
        if(correctedDay != 1)
          next
        end
      end
      if(oh.dow == "T")
        if(correctedDay != 2)
          next
        end
      end
      if(oh.dow == "W")
        if(correctedDay != 3)
          next
        end
      end
      if(oh.dow == "R")
        if(correctedDay != 4)
          next
        end
      end
      if(oh.dow == "F")
        if(correctedDay != 5)
          next
        end
      end
      if(oh.dow == "Su")
        if(correctedDay != 0)
          next
        end
      end
      
      if (oh.sHour > centralHour || oh.eHour < centralHour)
        next
      end
      
      if(oh.sHour == centralHour)
        if(oh.sMin > @time.min)
          next
        end
      end
      
      if(oh.eHour == centralHour)
        if(oh.eMin < @time.min)
          u = Update.find_by(timeID: oh.timeID)
          if(u)
            if(oh.change == "Delete" && u.date == today)
              oh.update(change: "No Change")
              session[oh.email] = 0
              u.destroy
            elsif(u.date == today)
              oh.update(change: "No Change")
              session[oh.email] = 0
              u.destroy
            end
          end
          next
        end
      end
      
      u = Update.find_by(timeID: oh.timeID)
      
      if(u && u.approved == 1)
        if(oh.change == "Delete" && u.date == today)
          session[oh.email] = 1
        elsif(oh.change == u.date && oh.change == today)
          session[oh.email] = 1
        end
      elsif(u && u.approved == 0)
        u.destroy
      end
      
      session[:available_pts].push(oh.email)
    end
  end
end
