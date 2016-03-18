class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :apartments

# the app collects information from twitter, keeps the information if the method decides to (i.e.remember me)
  def self.from_omniauth(auth)
    # twitter send back uid, the callback method uses this to login .where = search, provider = twitter, facebook var auth:pro = provider of info, twitter uid = # mathching a user.
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      # auth.uid is a # sent by twitter from thier API
      user.uid = auth.uid
      # user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
      user.attributes = params
      user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end
end
