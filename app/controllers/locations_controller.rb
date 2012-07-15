class LocationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  
  def geocoder_test
    
    @json = Array.new
    Post.each do |post|
    @json << ManualGeocoder.geocode(post.coordinates)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @json }
    end
  end
  
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    @json = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @json }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new
    
    if current_user.foursq_token && params[:fsq_venue_id]
      @venue = Fetchvenue.with_id(params[:fsq_venue_id], current_user.foursq_token)
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @location }
      end
    else
      redirect_to '/location_search', :notice => 'Please select venue first!'
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end
