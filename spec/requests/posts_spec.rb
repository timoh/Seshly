require 'spec_helper'

describe "Posts" do
  
  before do 
    user = FactoryGirl.create(:user, :nickname => "Bobbiezzz")
    @post = FactoryGirl.create(:post, :user => user, :description => "Morjesta")
  end
  
  context '#show' do
    
    describe 'when not signed in' do
      #example: coming from Twitter message
      it 'should only show basic information' do
        visit '/posts/'+@post.id.to_s
        page.should have_content('Bobbiezzz')
        page.should have_content('Morjesta')
        page.should_not have_content('See more')
        page.should_not have_content('Edit')
      end
      
      it 'should not let the user to view index' do
        visit '/posts/'
        page.should have_content('You need to sign in')
      end
      
      it 'should not let the user to edit' do
        visit '/posts/'+@post.id.to_s+'/edit' 
        page.should have_content('You need to sign in')
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
