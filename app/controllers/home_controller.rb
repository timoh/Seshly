class HomeController < ApplicationController
  def index
    @users = User.all
    @posts = Post.all
  end
end
