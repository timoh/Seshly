class Notificator < ActionMailer::Base
  default :from => "yritys@efekta.fi"
  
  def registration_confirmation(user)
    @user = user
    attachments["ohai.jpg"] = File.read("#{Rails.root}/public/images/ohai.jpg")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end