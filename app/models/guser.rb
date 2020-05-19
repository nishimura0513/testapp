class Guser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i(google)
           protected
           def self.find_for_google(auth)
             user = Guser.find_by(email: auth.info.email)
             unless user
               user = Guser.create(name:     auth.info.name,
                                 provider: auth.provider,
                                 uid:      auth.uid,
                                 token:    auth.credentials.token,
                                 email:    auth.info.email,
                                 password: Devise.friendly_token[0, 20],
                                 meta:     auth.to_yaml,
                                 image_name: "default.jpg")
             end
             user
           end


end
