class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, :type => String
  field :short_url, :type => String
  field :latitude, :type => Float
  field :longitude, :type => Float
  
  belongs_to :location
  belongs_to :user
  
  validates_associated :user
  #validates_uniqueness_of :short_url
  validates_presence_of [:description, :user]
  
  def self.latest
    self.all(sort: [[ :created_at, :desc ]], limit: 5)
  end

  
end
