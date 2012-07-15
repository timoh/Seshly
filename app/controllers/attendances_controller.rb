class AttendancesController < ApplicationController
  
  def create
    if current_user
      post = Post.find(params[:id])
      user = current_user
      @attendance = Attendance.new(:post => post, :user => user)
      
      respond_to do |format|
        if @attendance.save
          format.html { redirect_to post_path(post), notice: 'Your attendance was successfully recorded!' }
        else
          redirect_to post_path(post)
          format.json { render json: @attendance.errors, status: :unprocessable_entity }
        end
      end
      
    else
      
      redirect_to '/auth/twitter'
    
    end
  
  end
  
  def destroy
    if current_user
      @attendance = Attendance.find(params[:id])
      post = @attendance.post
      @attendance.destroy

      respond_to do |format|
        format.html { redirect_to post_path(post), notice: 'You bailing out was successfully recorded!' }
        format.json { head :no_content }
      end
      
    end
  end
  
end