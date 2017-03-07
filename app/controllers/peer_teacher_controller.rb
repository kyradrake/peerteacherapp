require 'nokogiri'
require 'open-uri'
require 'json'

class PeerTeacherController < ApplicationController
    
    def peerTeacher_params
        params.require(:peerTeachers).permit(:netID, :name, :courselist, :timelist)
    end
    
    def index
      if user_signed_in?
        sign_out current_user
      end
        @peer_teachers = PeerTeacher.all
        @office_hours = OfficeHour.all
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
                OfficeHour.create(:timeID => timeid, :netID => email, :dow => d, :sHour => sh, :sMin => sm, :eHour => eh, :eMin => em)
            end
            timeid += 1
            timeList += timeid.to_s + ','
            
            times = [sh, sm, eh, em]
            hrs = days.map{|d| [d] + times }
            copyhours = copyhours + hrs
          end
          
          allhours = copyhours[0,copyhours.length]
          
          copyhours.clear
          
          if(name)
            PeerTeacher.create(:netID => email, :name => name, :courselist => courses, :timelist => timeList, :image => imageURL)
          end
        end 
        redirect_to home_index_path
    end
end
