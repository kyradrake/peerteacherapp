require 'rest-client'
class ExampleMailer < ActionMailer::Base



  def sample_email(user)
  #  session[:user] = "MAILER"
    @user = user
    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
    message_params = {:from    => ENV['MAILGUN_SMTP_LOGIN'],
                      #:to      => @user.email,
                      :to      =>'justing169589@gmail.com',
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
   mg_client.send_message ENV['send_domain'], message_params
   #Error is in the above line
  end
  
    API_KEY = ENV['MAILGUN_API_KEY']
    #API_URL = "https://api.mailgun.net/v3/app85cae7084bcf43aca41019d9595fd9d7.mailgun.org"
    API_URL = "https://api:#{API_KEY}@api.mailgun.net/v3/app85cae7084bcf43aca41019d9595fd9d7.mailgun.org" 
  
  def api_email(emailAddr, toAdmin, id)
  #   session[:user] = "MAILER"
  #   @user = user
    @peer_teachers = PeerTeacher.all
    @updates = Update.all
    up = @updates.find_by timeID: id;
    
    #@admins = Administrator.all
    #@shouldNotify = @admins.where(notification: pt).find_each
    #toAddress = ""
    #for i in 0..@shouldNotify.size
    #  if (i != (@shouldNotify.size - 1))
    #    toAddress += @shouldNotify[i] + ", "
    #  else
    #    toAddress += @shouldNotify[i]
    #  end
    #end
    
    if(toAdmin)
      RestClient.post "https://api:key-e2f88fd75e1de008e3a8a707665ac1d8@api.mailgun.net/v3/app85cae7084bcf43aca41019d9595fd9d7.mailgun.org/messages",
          :from => "postmaster@app85cae7084bcf43aca41019d9595fd9d7.mailgun.org",
          :to => "k4sr4@tamu.edu", #admin emails who have been chosen to be notified should be added here
          :subject => "Schedule Change for " + (@peer_teachers.find_by email: emailAddr).name,
          :text => "Text body",
          :html => "<b>" + (@peer_teachers.find_by email: emailAddr).name + "</b> has made a schedule change:<br>" + up.action + ": " + up.dow + " " + up.date + " @" + up.sHour.to_s + ":" + up.sMin.to_s + " - " + up.eHour.to_s + ":" + up.eMin.to_s + "<br>Reason: " + up.msg + "<br>Click on the Following Link to Deny the Change -  <a href='https://pttamu.herokuapp.com/updates/" + id.to_s + "/edit'>Deny</a> <br>NOTE - Any changes not approved after 24hrs will be automatically accepted !  ",  
          :o => "tracking-clicks, tag", 
          :tag => "Put User Key Hhere"
    else
      RestClient.post "https://api:key-e2f88fd75e1de008e3a8a707665ac1d8@api.mailgun.net/v3/app85cae7084bcf43aca41019d9595fd9d7.mailgun.org/messages",
          :from => "postmaster@app85cae7084bcf43aca41019d9595fd9d7.mailgun.org",
          :to => emailAddr,
          :subject => "Your Schedule Change was Disapproved",
          :text => "Text body",
          :html => "Howdy " + (@peer_teachers.find_by email: emailAddr).name + "! <br>Your schedule change was disapproved by an administrator. The details for the disapproved schedule change can be found below:<br>" + up.action + ": " + up.dow + " " + up.date + " @" + up.sHour.to_s + ":" + up.sMin.to_s + " - " + up.eHour.to_s + ":" + up.eMin.to_s + "<br>Reason: " + up.msg,  
          :o => "tracking-clicks, tag", 
          :tag => "Put User Key Hhere"
    end

  end
  
  
  
 # api_email(user)
  
end