require 'nokogiri'
require 'open-uri'
require 'json'

class PeerTeacherController < ApplicationController
    def peerTeacher_params
        params.require(:peerTeachers).permit(:netID, :name, :courselist, :timelist)
    end
    
    def index
        @peer_teachers = PeerTeacher.all
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
       url = 'https://engineering.tamu.edu/cse/academics/peer-teachers/current-peer-teachers'
        html = open(url)
        doc = Nokogiri::HTML(html)
        
        
         people = []
         day = []
         #time =[]
         doc.css('.record').each do |record|
         imageURL =record.css('img').map{ |i| i['src'] }
         #imageURL =record.xpath('//img/@src')
         name_el = record.css('h3')  
         name = name_el.text.strip 
         email =record.css('h4 a').map{ |i| i['href'] }
         courses = record.css('li').map { |course| course.text.strip } 
         #day = record.css('td').text.strip
         day = record.css('td').map { |da| da.text.strip } 
         #time =record.css('td').text.strip
         #dt =  doc.xpath('//*/table/tbody/tr').each do |td|
         #dt << td.text
         #end
        
        
        #<tr>
        #<td>W</td>
        #<td>3:00 - 4:00 pm</td>
        #</tr>
        
        
          people.push(
            name: name,
            email: email,
            imageURL: imageURL,
            courses: courses,
            day: day
          )
          
           PeerTeacher.create(:netID => email, :name => name, :courselist => courses, :timelist => day)
        end 
        redirect_to home_index_path
    end
end
