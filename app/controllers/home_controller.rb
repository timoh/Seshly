class HomeController < ApplicationController
  def index
    @users = User.all
    @posts = Post.latest
    
    # send user a notification email
    if current_user
      send_notification(current_user)
    end
    
  end
end
