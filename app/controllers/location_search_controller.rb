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
          @fsq_locs = Fetchvenue.with_keyword(params[:location], access_token)
          
          @location = Location.where(name: "#{params[:location]}")
      end
      
    else
      redirect_to '/signin', :notice => 'Please sign in first!'
    end
  end
  
  def save_token
    raise 'CALLBACK CODE NEEDED TO GENERATE ACCESS TOKEN!' if params[:code] == nil
    if current_user
    
      if (params[:code])
        if (params[:code].length > 0)
          current_user.foursq_token = Fetchvenue.generate_access_token(params['code'])
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
  
  def show_venue_raw
    @venue = Fetchvenue.with_id(params[:fsq_venue_id], current_user.foursq_token)
    respond_to do |format|
      format.json { render json: @venue }
    end
  end
  
end