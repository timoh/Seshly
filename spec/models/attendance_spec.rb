require 'spec_helper'

describe Attendance do
    it 'should have both owner and a post' do
    # create normal user and attach to post
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, :user => user)
    post.save!
    
    # create attendee and attach to post
    attendance = FactoryGirl.create(:attendance)
    attendee = FactoryGirl.create(:user)
    
    attendance.user = attendee
    attendance.post = post
    attendance.save!
    
    post.attendances.first.user.should == attendee
    attendee.attendances.first.post.should == post
    
  end
end
