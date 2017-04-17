class ApplicationMailer < ActionMailer::Base
  default from: "postmaster@app85cae7084bcf43aca41019d9595fd9d7.mailgun.org"
  layout 'mailer'
end
