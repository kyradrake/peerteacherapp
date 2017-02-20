require 'nokogiri'
require 'open-uri'
require 'json'

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
end



puts JSON.pretty_generate(people)