class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :provider, :type => String
  field :uid, :type => String
  field :nickname, :type => String
  field :name, :type => String
  field :email, :type => String
  field :image, :type => String
  field :description, :type => String
  field :foursq_token, :type => String
  field :admin, :type => Boolean, default: false
  field :singup_email_sent, :type => Boolean, default: false
  attr_accessible :provider, :uid, :name, :email, :nickname
  
  has_many :posts
  has_many :attendances

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.nickname = auth['info']['nickname'] || ""
         user.email = auth['info']['email'] || ""
         user.image = auth['info']['image'] || ""
         user.description = auth['info']['description'] || ""
      end
    end
  end
  
  def already_attending?(post)
    attendance_for_this_event = self.attendances.all_in(:post_id => post.id) # USED TO BE: self.attendances.includes(post.attendances)
    
    if attendance_for_this_event.length > 0
      return true 
    else
      return false
    end
  end

end
