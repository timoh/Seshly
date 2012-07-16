require 'spec_helper'

describe Post do
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  
  
  it 'should return coordinates' do
        user = FactoryGirl.create(:user)
        post = FactoryGirl.create(:post, :user => user, :latitude => 20.0, :longitude => 30.0)
        post.coordinates[0].should == 20.0
        post.coordinates[1].should == 30.0
  end
  
  it 'should return false if latitude & longitude are empty' do
        user = FactoryGirl.create(:user)
        post = FactoryGirl.create(:post, :user => user, :latitude => nil, :longitude => nil)
        post.coordinates.should be_false
  end
  
  it 'should handle attendances and removing them' do
    flunk
  end
  
end