class ModelMailer < ApplicationMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #
   default from: "postmaster@sandboxf28360f40d454ef09bf3ec3d0d980eed.mailgun.org"
  
  def new_record_notification(record)
    @record = record

    mail to: "kyradrake@tamu.edu", subject:"This is a Test" 
  end
  
  
  
end
