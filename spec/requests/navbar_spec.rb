require 'spec_helper'

describe "Navbar" do
  describe "login button" do
    describe 'when user is signed in' do
      
      before do 
        OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new ({
          :provider => 'twitter',
          :uid => '123545',
          :info => {
            :name => 'Bobbie B.',
            :nickname => 'bobbieb'
          }
        })
      end
      
      it 'should read Twitter handle' do
        visit '/auth/twitter'
        visit root_path
        page.should have_content(User.first.nickname)
      end
      
    end
    
  end
end
