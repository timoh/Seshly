require 'spec_helper'

describe "Locations" do
  
  before do 
    user = FactoryGirl.create(:user)
    @post = FactoryGirl.create(:post, :user => user)
  end
  
  context '#show' do
    
    describe 'when not signed in' do
      #example: coming from Twitter message
      it 'should only show basic information' do
        visit '/posts/'+@post.id.to_s
        page.should have_content('on')
      end
    end
  
    describe 'when signed in' do
  
      before do
        visit '/auth/twitter'
      end
  
      it 'should only show basic information' do
        visit '/posts/'+@post.id.to_s
        page.should have_content('Edit')
      end
    end
  end
    
end
