class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :provider, :type => String
  field :uid, :type => String
  field :nickname, :type => String
  field :name, :type => String
  field :email, :type => String
  field :foursq_token, :type => String
  attr_accessible :provider, :uid, :name, :email, :nickname
  
  has_many :posts

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end
