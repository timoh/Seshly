class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, :type => String
  field :short_url, :type => String
  field :latitude, :type => Float
  field :longitude, :type => Float
  
  belongs_to :location
  
  belongs_to :user
  has_many :attendances
  
  validates_associated :user
  #validates_uniqueness_of :short_url
  validates_presence_of [:description, :user]
  
  def coordinates
    coordinates = Array.new
    
    coordinates.push self.latitude
    coordinates.push self.longitude
    
    if self.latitude == nil || self.longitude == nil
      return false
    end
    
    if self.latitude > 0 && self.longitude > 0
      return coordinates
    else
      return false
    end
  end
  
  def self.latest
    self.all.sort(created_at: -1).limit(5)
  end

  
end
