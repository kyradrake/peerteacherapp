require 'nokogiri'
require 'open-uri'
require 'json'

class PeerTeacherController < ApplicationController
    
    def peerTeacher_params
        params.require(:peerTeachers).permit(:email, :name, :courselist, :timelist)
    end
    
    def index
      #session[:available_pts].clear
      @time = Time.new
      if user_signed_in?
        sign_out current_user
      end
      @peer_teachers = PeerTeacher.all
      @office_hours = OfficeHour.all
      @updates = Update.all
      #populate_db
      availables
    end
   
    def show
        @peer_teacher = PeerTeacher.find(params[:id])
    end
   
    def new
        @peer_teacher = PeerTeacher.new
        @office_hours = OfficeHour.all
    end
   
    def create
        @peer_teacher = PeerTeacher.new(peerTeacher_params)
	
        if @peer_teacher.save
            redirect_to :action => 'list'
        else
            @office_hours = OfficeHour.all
            render :action => 'new'
        end
    end
   
    def edit
        @peer_teacher = PeerTeacher.find(params[:id])
        @office_hours = OfficeHour.all
    end
   
    def update
        @peer_teacher = PeerTeacher.find(params[:id])
	
        if @peer_teacher.update_attributes(book_param)
           redirect_to :action => 'show', :id => @peer_teacher
        else
           @office_hours = OfficeHour.all
           render :action => 'edit'
        end
    end
   
    def delete
        PeerTeacher.find(params[:id]).destroy
        redirect_to :action => 'list'
    end
    
    def show_office_hours
        @office_hours = OfficeHour.find(params[:id])
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
              end
              
              if tmp[1].include? "am"
                tmp[1].delete!("am").strip!
              end
            end
            
            if tmp[1].include? "pm"
              tmp[1].delete!("pm").strip!
              tmp[1] = tmp[1].to_i > 1200 ? tmp[1] : (tmp[1].to_i + 1200).to_s
            end
                
            sh = tmp[0][0..-3]
            sm = tmp[0][-2..-1]
            eh = tmp[1][0..-3]
            em = tmp[1][-2..-1]
            
            if (sh == '24')
              sh = '12'
            end
            if(eh == '24')
              eh = '12'
            end
            
            days.each do |d| 
                OfficeHour.create(:timeID => timeid, :email => email, :dow => d, :sHour => sh, :sMin => sm, :eHour => eh, :eMin => em, :change => "No Change")
            end
            timeid += 1
            timeList += timeid.to_s + ','
            
            times = [sh, sm, eh, em]
            hrs = days.map{|d| [d] + times }
            copyhours = copyhours + hrs
          end
          
          allhours = copyhours[0,copyhours.length]
          
          copyhours.clear
          
          if(name != '')
            PeerTeacher.create(:email => email, :name => name, :courselist => courses, :timelist => timeList, :image => imageURL)
          end
        end 
        redirect_to home_index_path
    end
    
    def availables
      @time = Time.new
      centralHour = @time.hour - 5
      if(centralHour < 0)
        centralHour += 24
      end
      
      today = (@time.month.to_s + "/" + @time.day.to_s + "/" + @time.year.to_s)
      
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
      Update.delete_all #MAKE SURE TO COMMENT THIS WHEN DONE WITH TESTING
      @office_hours.where(email: "darrencola@tamu.edu").find_each do |kevinTime|
        if(kevinTime.dow == "Su")
          kevinTime.update(change: "Delete")
          Update.create(:timeID => kevinTime.timeID, :email => kevinTime.email, :dow => "", :sHour => "", :sMin => "", :eHour => "", :eMin => "", :oldDate => "3/26/2017", :newDate => "", :action => "Delete", :msg => "TEST 1", :approved => 1)
        end
      end
      
      @office_hours.where(email: "tcarlson25@tamu.edu").find_each do |tylerTime|
        if(tylerTime.dow == "Su")
          tylerTime.update(change: "3/26/2017")
          Update.create(:timeID => tylerTime.timeID, :email => tylerTime.email, :dow => "Su", :sHour => 16, :sMin => 40, :eHour => 16, :eMin => 56, :oldDate => "3/26/2017", :newDate => "3/26/2017", :action => "Update", :msg => "TEST 2", :approved => 1)
        end
      end
      
      @updates = Update.all
      
      updateDone = false
      origDone = false
      
      @updates.each do |oh|
        if(oh.action == "Update" && oh.newDate == today)
          if(oh.dow == "M")
            if(@time.wday != 1)
              next
            end
          end
          if(oh.dow == "T")
            if(@time.wday != 2)
              next
            end
          end
          if(oh.dow == "W")
            if(@time.wday != 3)
              next
            end
          end
          if(oh.dow == "R")
            if(@time.wday != 4)
              next
            end
          end
          if(oh.dow == "F")
            if(@time.wday != 5)
              next
            end
          end
          if(oh.dow == "Su")
            if(@time.wday != 0)
              next
            end
          end
          
          if (oh.sHour > centralHour || oh.eHour < centralHour)
            if(oh.eHour < centralHour)
              updateDone = true
              orig = @office_hours.find_by(timeID: oh.timeID)
              if(orig && updateDone && origDone)
                orig.update(change: "No Change")
                session[oh.email] = 0
                oh.destroy
              end
            end
            next
          end
          
          if(oh.sHour == centralHour)
            if(oh.sMin > @time.min)
              next
            end
          end
  
          if(oh.eHour == centralHour)
            if(oh.eMin < @time.min)
              next
            end
          end
          
          if(oh.newDate == today)
            session[:available_pts].push(oh.email)
          end
        end
      end
      
      @office_hours.each do |oh|
        if(oh.dow == "M")
          if(@time.wday != 1)
            next
          end
        end
        if(oh.dow == "T")
          if(@time.wday != 2)
            next
          end
        end
        if(oh.dow == "W")
          if(@time.wday != 3)
            next
          end
        end
        if(oh.dow == "R")
          if(@time.wday != 4)
            next
          end
        end
        if(oh.dow == "F")
          if(@time.wday != 5)
            next
          end
        end
        if(oh.dow == "Su")
          if(@time.wday != 0)
            next
          end
        end
        
        if (oh.sHour > centralHour || oh.eHour < centralHour)
          if(oh.eHour < centralHour)
            u = Update.find_by(timeID: oh.timeID)
            if(u)
              origDone = true
              if(oh.change == "Delete" && u.oldDate == today)
                oh.update(change: "No Change")
                session[oh.email] = 0
                u.destroy
              elsif(origDone && updateDone && u.oldDate == today)
                oh.update(change: "No Change")
                session[oh.email] = 0
                u.destroy
              end
            end
          end
          next
        end
        
        if(oh.sHour == centralHour)
          if(oh.sMin > @time.min)
            next
          end
        end
        
        if(oh.eHour == centralHour)
          if(oh.eMin < @time.min)
            next
          end
        end
        
        u = Update.find_by(timeID: oh.timeID)
        
        if(u)
          if(oh.change == "Delete" && u.oldDate == today)
            session[oh.email] = 1
          elsif(oh.change == u.oldDate && oh.change == today)
            session[oh.email] = 1
          end
        end
        
        session[:available_pts].push(oh.email)
      end
      #redirect_to home_index_path
    end
end
