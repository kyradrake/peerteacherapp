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
  
  def api_email(user)
  #   session[:user] = "MAILER"
  #   @user = user
    RestClient.post "https://api:key-e2f88fd75e1de008e3a8a707665ac1d8@api.mailgun.net/v3/app85cae7084bcf43aca41019d9595fd9d7.mailgun.org/messages",
        :from => "postmaster@app85cae7084bcf43aca41019d9595fd9d7.mailgun.org",
        #:to => "justing169589@gmail.com",
        :to => " k4sr4@tamu.edu",
        :subject => "Schedule Change",
        :text => "Text body",
        :html => "<b>The Following Peer Teacher USER</b> has changed Click on the Following Link to Deny the Change -  <a href='https://peerteacherapp2-k4sr4.c9users.io/updates/100/edit'>Deny</a> :NOTE - Anychanges not approved after 24hrs will be automatically accepted !  ",  
        :o => "tracking-clicks, tag", 
        :tag => "Put User Key Hhere"

  end
  
  
  
 # api_email(user)
  
end