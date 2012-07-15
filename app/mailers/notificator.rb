class Notificator < ActionMailer::Base
  default :from => "timo.herttua@efekta.fi"
  
  def registration_confirmation(user)
    @user = user
     attachments["ohai.jpg"] = File.read("#{Rails.root}/public/images/ohai.jpg")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
  
  def notify_attendance(to_user, attending_user, post)
    @attending_user = attending_user
    @to_user = to_user
    @post = post
    mail(:to => "#{user.name} <#{user.email}>", :subject => "A new attendee to your post #{@post.description}")
  end
  
end