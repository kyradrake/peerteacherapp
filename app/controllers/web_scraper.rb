require 'nokogiri'
require 'open-uri'
require 'json'

url = 'https://engineering.tamu.edu/cse/academics/peer-teachers/current-peer-teachers'
html = open(url)
doc = Nokogiri::HTML(html)
@tag_separator = ' -'

  people = []
  sched = []
  allhours = []
  copyhours = []
  time = []
 
  #for class record
  doc.css('.record').each do |record|
  imageURL = record.css('img').map{ |i| i['src'] }
  name_el = record.css('h3')  
  name = name_el.text.strip 
  email = record.css('h4 a').map{ |i| i['href'] }
  courses = record.css('li').map { |course| course.text.strip.split(/(\s\d+)/) } 
  courses = courses.map { |v| v[1] }
  
  #check for null here there's an empty person at the end, but this is maybe just nitpicking at this point
  sched = record.css('td').map { |days| days.text.strip } 

  while sched.any?
    officehours = sched.shift(2)
    days = officehours[0].split(/(M|T|W|R|F|SU)/)
    days.delete("")
    puts "officehours #{officehours}"
  
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
    
    times = [sh, sm, eh, em]
    hrs = days.map{|d| [d] + times }
    copyhours = copyhours + hrs
  end
  
  allhours = copyhours[0,copyhours.length]

  people.push(
    name: name,
    email: email,
    imageURL: imageURL,
    courses: courses,
    allhours: allhours
  )
  
  copyhours.clear
end

puts JSON.pretty_generate(people)