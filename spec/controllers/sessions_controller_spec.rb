require 'spec_helper'

describe SessionsController do
	
  before(:each) do
		OmniAuth.config.test_mode = true
		OmniAuth.config.mock_auth[:twitter] = {
		    'uid' => '12345',
		    'provider' => 'twitter',
		    'info' => {
		      'name' => 'Bob',
		      'email' => 'bob@example.com'
		    }
		  }
	end

end
