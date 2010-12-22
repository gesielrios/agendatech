class User < ActiveRecord::Base
  has_many :authentications
  has_many :gadgets
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nickname, :image

  def vai_no? evento
    return true if Gadget.where(:evento_id => evento.id, :user_id => self.id).first
    false
  end
end
