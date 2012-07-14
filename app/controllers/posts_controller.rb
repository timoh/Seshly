class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :new]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    if !current_user
      redirect_to '/auth/twitter'
    else
        @token = current_user.foursq_token
        @post = Post.new

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @post }
        end
    end
    
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    raise 'NO CURRENT USER SET!' if current_user == nil
    raise 'CURRENT USER NAME NOT VALID!' if current_user.name.length < 3
    
    @post.user = current_user
    
    foursquare_id = params[:post][:foursquare_id]
    
    if foursquare_id
      if current_user.foursq_token
        if current_user.foursq_token.length > 0
          if foursquare_id.length > 0
            venue = Fetchvenue.with_id(foursquare_id, current_user.foursq_token)
            
            #if a location with this foursq_id doesn't exists..
            location = Location.where(foursq_id: venue.id).first
            if location == nil
              
              #create a new location
              new_loc = Location.new(:foursq_id => venue.id, :name => venue.name, :lat => venue.location.lat, :lng => venue.location.lng)
              
              #additional attributes // refactor this to a model!
              if venue.location.respond_to?('address')
                new_loc.street_address = venue.location.address
              end
              
              if venue.location.respond_to?('city')
                new_loc.city = venue.location.city
              end
              
              if venue.location.respond_to?('country')
                new_loc.country = venue.location.country
              end
              
              #add other attributes later
              new_loc.save!
              
              #join new location to the post
              @post.location = new_loc
            else
              #otherwise, just link the existing location to the post
              @post.location = location
            end
              
          end
         else
          redirect_to foursquare.authorize_url(ENV['DOMAIN_URL']+"/location_search/save_token")
        end
      else
        redirect_to foursquare.authorize_url(ENV['DOMAIN_URL']+"/location_search/save_token")
      end
    end  
    
    
    

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
