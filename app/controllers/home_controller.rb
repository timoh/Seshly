class HomeController < ApplicationController
  def index
    @users = User.all
    @posts = Post.latest
  end
end
