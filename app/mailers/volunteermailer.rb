class Volunteermailer < ApplicationMailer
 default from: ENV['mail_sender']

 include Sidekiq::Mailer
   
   def became_volunteer_email(email, eventName)
      @email = email
      @eventName = eventName
      mail(to: @email,
         subject: 'You have been made a volunteer',)
   end

end