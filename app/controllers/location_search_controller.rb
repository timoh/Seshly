class LocationSearchController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    # make sure user is signed in
    if current_user
      foursquare = Foursquare::Base.new(ENV['FOURSQUARE_KEY'], ENV['FOURSQUARE_SECRET'])
      
      # if user is trying to search but has not yet created token, first require to create token
      if (params[:location] && current_user.foursq_token == nil)
        redirect_to foursquare.authorize_url(ENV['DOMAIN_URL']+"/location_search/save_token")
      end
    
      # if token exists & token ins created, continue with fetching the location
      if params[:location]
        search_venue(params[:location])
      end
      
    # you cannot use the location search without signing in!  
    else
      redirect_to '/signin', :notice => 'Please sign in first!'
    end
  end
  
  def save_token
    if current_user == nil
      redirect_to '/signin', :notice => 'Please sign in first!'
    end
    # make sure user is signed in
    raise 'CURRENT USER NOT SET!' if current_user == nil
      
    # make sure callback code exists (needed as a parameter)
    raise 'CALLBACK CODE NEEDED TO GENERATE ACCESS TOKEN!' if params[:code] == nil
    if (params[:code])
      if (params[:code].length > 0)
        
        # if user signed in AND code exists, generate token and save it to database
        current_user.foursq_token = self.generate_token(params['code'])
        raise 'FOURSQUARE TOKEN SAVE FAILED!' unless current_user.save!
      end   
    end
    
    # communicate different typical errors
    raise 'REDIRECT URI MISMATCH!' if params[:error] == 'redirect_uri_mismatch'
    raise 'FOURSQUARE TOKEN NOT SAVED!' if current_user.foursq_token == nil || current_user.foursq_token.length == 0
    
    # otherwise, display success message
    redirect_to '/location_search', :notice => 'Request successful!'
  end
  
  # for testing purposes, used to fetch single venues from FSq
  def show_venue_raw
    @venue = self.fetch_with_id(params[:fsq_venue_id])
    respond_to do |format|
      format.json { render json: @venue }
    end
  end
  
  private
  
    def search_venue(location)
          access_token = current_user.foursq_token
          raise 'access_token is nil!' if access_token == nil
  
          # any way to sanitize input??
          search_query = location
           
          @fsq_locs = Fetchvenue.with_keyword(search_query, access_token)
          @location = Location.where(name: /#{search_query}/i).first
    end
   
    #
    # IDEA HERE WAS TO MAKE THESE METHODS MORE TESTABLE,
    # BUT ....
    #
    
    def self.generate_token(code)
      return Fetchvenue.generate_access_token(code)
    end
  
    def self.fetch_with_id(venue_id)
       return Fetchvenue.with_id(venue_id, current_user.foursq_token)
    end
  
end