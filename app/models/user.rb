class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 after_create :save_authentication_token

 def save_authentication_token
 	self.update(:authentication_token => Devise.friendly_token[0,10])
 end
end