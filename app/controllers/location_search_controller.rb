class LocationSearchController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if current_user
      foursquare = Foursquare::Base.new(ENV['FOURSQUARE_KEY'], ENV['FOURSQUARE_SECRET'])
      
      if (params[:location] && current_user.foursq_token == nil)
        redirect_to foursquare.authorize_url(ENV['DOMAIN_URL']+"/location_search/save_token")
      end
    
      if params[:location] && 
          access_token = current_user.foursq_token
          
          raise 'access_token is nil!' if access_token == nil
          
          foursquare = Foursquare::Base.new(access_token)
          output = foursquare.venues.search(:ll => '44.3,37.2', :near => "Helsinki, Finland", :query => "#{params[:location]}", :oauth_token => access_token) # Returns all resulting groups
          
          @fsq_locs = output['places']
          
          @location = Location.where(name: "#{params[:location]}")
      end
      
    else
      redirect_to '/signin', :notice => 'Please sign in first!'
    end
  end
  
  def save_token
    raise 'NEED THE ACCESS CODE IN ORDER TO GENERATE ACCESS TOKEN!' if params[:code] == nil
    if current_user
      foursquare = Foursquare::Base.new(ENV['FOURSQUARE_KEY'], ENV['FOURSQUARE_SECRET'])
    
      if (params[:code])
        if (params[:code].length > 0)
          current_user.foursq_token = foursquare.access_token(params["code"], ENV['DOMAIN_URL']+"/location_search/")
          raise 'FOURSQUARE TOKEN SAVE FAILED!' unless current_user.save!
        end   
      end
    else
      redirect_to '/signin', :notice => 'Please sign in first!'
    end
    
    raise 'REDIRECT URI MISMATCH!' if params[:error] == 'redirect_uri_mismatch'
    raise 'FOURSQUARE TOKEN NOT SAVED!' if current_user.foursq_token == nil || current_user.foursq_token.length == 0
    redirect_to '/location_search', :notice => 'Request successful!'
  end
  
end