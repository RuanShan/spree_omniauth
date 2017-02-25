# each user can use different socialnetwork for same account
Spree::User.class_eval do
  has_many :oauth_accounts

  #https://github.com/plataformatec/devise/wiki/OmniAuth%3A-Overview
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end


  # search user by provider and data
  # in migration exist index
  def self.find_by_provider_and_uid(provider,uid)
    self.joins(:oauth_accounts).where(:oauth_accounts => {:provider => provider,:uid => uid }).limit(1).first
  end

  def self.create_by_auth(auth)
    begin
    user = self.new
    user.login = auth['user_info']['nickname']
    user.persistence_token = Authlogic::Random.hex_token
    user.save!(false) # save without validation
    user.oauth_accounts.create(
                        :provider => auth['provider'],
                        :uid => auth['uid'],
                        :user_info => auth['user_info'],
                        :name => auth['user_info']['name']
                       )
    return user
    rescue =>e
      puts e
    end
  end
end
