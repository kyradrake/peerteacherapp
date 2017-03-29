   #require 'action_mailer'
   #require 'active_support'
#require 'active_support/core_ext'
   
#ActionMailer::Base.raise_delivery_errors = true
#ActionMailer::Base.default_options = {:host => "https://peerteacherapp2-k4sr4.c9users.io" }
#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.smtp_settings = {
 # :authentication => :plain,
 # :address => "smtp.mailgun.org",
 # :port => 2525,
  #:port => 587,
 # :domain => "sandboxf28360f40d454ef09bf3ec3d0d980eed.mailgun.org",
  #:user_name => "postmaster@sandboxf28360f40d454ef09bf3ec3d0d980eed.mailgun.org",
  #:password => "de75808bb50e0e705ed84dbf5293a58f",
  #:enable_starttls_auto => true,
  #:ssl =>false
  #}   
   
   
 
   
   
class MailerTest < ActionMailer::Base
      
      #def create
       
            
        #@record = "BOB OBJECT"      
       # ModelMailer.new_record_notification(@record).deliver
        
       
       #  mail to: "kyradrake@tamu.edu", subject:"This is a Test" 
     
      #end
      
#email =  ModelMailer.create
#puts email
#email.deliver
      
      create
end    