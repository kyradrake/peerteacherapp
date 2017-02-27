require 'nokogiri'
require 'open-uri'
require 'json'


#http://stackoverflow.com/questions/11272773/how-to-correctly-parse-this-bad-html-in-nokogiri
#http://stackoverflow.com/questions/3484874/how-to-split-a-html-document-using-nokogiri
#http://stackoverflow.com/questions/20793783/using-split-with-nokogiri
#

url = 'https://engineering.tamu.edu/cse/academics/peer-teachers/current-peer-teachers'
html = open(url)
doc = Nokogiri::HTML(html)
@tag_separator = ' -'

  people = []
  sched = []
  day = []
  time = []
 
  #for class record
  doc.css('.record').each do |record|
  imageURL = record.css('img').map{ |i| i['src'] }
  #imageURL = record.xpath('//img/@src')
  name_el = record.css('h3')  
  name = name_el.text.strip 
  email = record.css('h4 a').map{ |i| i['href'] }
 #courses = record.css('li').map { |course| course.text.strip } 
   courses = record.css('li').map { |course| course.text.strip.split(/(\s\d+)/) } 
   courses = courses.map { |v| v[1] }
  
  
  
#OLDCODE KEPT FOR REFERENCE  
   #courses.each {|i| puts [([i][1])]  }
   
  # courses.each_with_index do |x, xi|
  #x.each_with_index do |y, yi|
   # puts "element [#{xi}, #{yi}] is #{y}"
  #end
#end
 #courses.each_with_index do |(x, y)|
 # puts courses.map { |v| v[1] }
#end
   
 #courses = record.css('li').map { |course| course.text.strip.delete("CSCE").split(/(\s\d+)/) } 
 #course2 = courses.map { |course| course.delete(/(\s\-)/) }
 # courses = record.css('li').map { |course| course.text.strip.split(/(CSCE\s\d+\s)/) } 
#USELES CODE END

 #courses = courses.split(/\W+-/)
 #between CSCE and a - 
 
 #day = record.css('td').text.strip
 #day = record.css('td').map { |days| days.text.strip.split(/<td>\D+<\/td>/) } 
 
  #Grabs Actual Data and turns into an array
  sched = record.css('td').map { |days| days.text.strip.split(/<td>(TWR|MW|TF|WF|TR|M|T|W|TH|F|R|SU)<\/td>/) } 
  #puts sched
  
  #check for null here
  schedtmp = record.css('td').map { |days| days.text.strip :  } 
  #puts "schedtmp #{schedtmp}"
  tmp1 = schedtmp.shift(2)
  puts "tmp1 #{tmp1}"
  
  
  #puts "DONE WITH PERSON" 
    #Data for time and date alternate due to us of split above this seperates it for use
    time = sched.select.with_index { |_, i| i.odd? }
    #puts "time #{time}"
    day = sched.select.with_index { |_, i| i.even? }
    #puts "day #{day}"
   
   
    #TIME WORK AREA
  
   
     #times = time.map { |tm| tm.split(/(\s-\s)/) }
     #times = time.map { |tm| tm.text.strip.gsub((/\d+?:/), '') }
     
    sh = []
    sm = []
    eh = []
    em = []
     
    tmp = []
    
  #time.each_with_index do |x, xi|
    #x.each_with_index do |y, yi|
      tmp = tmp1[1].split("-").map{|derp| derp.strip!.delete(":")}
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

    #end
  #end
  
    puts "SH #{sh}  SM #{sm}  EH #{eh}  EM #{em}"
    puts "DONE WITH PERSON"
 #derp = y.delete("-:pmam ")
     #puts derp
    #shtemp = y.delete("/(:\d+\s(pm\s|am\s)?)-/") 
    #puts shtemp
    #  hi = y.sub((/\d+?:/),"")
    #uses regex to get rid 
    #there is a way to check if the string includes am and pm, use this to later add 12 to the HR
    #can use gsub and will keep checking pattern
     # temptime.push("#{hi}") 
     #puts "element [#{xi}, #{yi}] is #{y}"  
  
  
 
  # puts temptime
#puts "DONE WITH PERSON" 

     
     
     
     #\d+?:|\d\d|\s-\s|pm|am|\spm|\sam
     #times = time.select.with_index{ |tm| tm[1].split(/(\s)/)  }
     # puts "#{time} E " 
       #puts "#{time[0].gsub((/\d+?:/), '')}" 
      
   
   #END TIME WORK AREA
   
   
   #SH SM EH EM
   
 
  #used to view data sets  
  # puts "#{time} #{day}"
  
 


#<tr>
#<td>W</td>
#<td>3:00 - 4:00 pm</td>
#</tr>
#get rid of CSCE, Section number and convert time into military time

  people.push(
    name: name,
    email: email,
    imageURL: imageURL,
    courses: courses,
    day: day,
    sh: sh,
    sm: sm,
    eh: eh,
    em: em
  )
end



#puts JSON.pretty_generate(people)