class AttendancesController < ApplicationController
  
  def create
    if current_user
      post = Post.find(params[:id])
      user = current_user
      
      unless user.already_attending?(post)
      
        @attendance = Attendance.new(:post => post, :user => user)
      
        respond_to do |format|
          if @attendance.save
            Notificator.notify_attendance(post.user, user, post).deliver
            format.html { redirect_to post_path(post), notice: 'Your attendance was successfully recorded!' }
          else
            redirect_to post_path(post)
            format.json { render json: @attendance.errors, status: :unprocessable_entity }
          end
        end
        
      else
        redirect_to post_path(post), notice: 'You can only attend a sesh once!'
      end
      
    else
      
      redirect_to '/auth/twitter'
    
    end
  
  end
  
  def destroy
    if current_user
      post = Post.find(params[:id])
      attendances = post.attendances.all_in(:user_id => current_user.id)
      
      if attendances.length > 0
        attendances.destroy
      else
        logger.warn 'AttendancesController WARNING: #{current_user.name} tried to remove attendance on #{post.description} but attendances were nil.'
      end
      

      respond_to do |format|
        format.html { redirect_to post_path(post), notice: 'You bailing out was successfully recorded!' }
        format.json { head :no_content }
      end
      
    end
  end
  
end
