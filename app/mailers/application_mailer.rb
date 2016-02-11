class ApplicationMailer < ActionMailer::Base
  default from: ENV['mail_sender']
  layout 'mailer'

end
