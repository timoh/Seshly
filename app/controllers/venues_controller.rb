class VenuesController < ApplicationController
  
  def index
    query = params[:location]
    access_token = params[:access_token]
    
    raise 'ACCESS TOKEN MISSING' if !access_token
    raise 'ACCESS TOKEN NOT VALID' if access_token.length < 3
    
    @venue = Fetchvenue.with_id(query, access_token)
    
    respond_to do |format|
      format.html
      format.json { render json: @venue }
    end
    
  end
  
  
end