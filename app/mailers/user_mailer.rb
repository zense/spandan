class UserMailer < ApplicationMailer
 default from: ENV['mail_sender']

 include Sidekiq::Mailer
   
   # You can create further functions like this for various mails, rememebr to create views also in views/user_mailer folder
   # You can ask to send an email lazily by calling function UserMailer.registration_email(@user.email, @data).deliver
   # If you want the email to be sent immedietly add ! at the end i.e. UserMailer.registration_email(@user.email, @data).deliver!
   def registration_email(email, data)
      @email = email
      @eventName = data
      mail(to: @email,
         subject: 'Awesome subject')
   end
end
