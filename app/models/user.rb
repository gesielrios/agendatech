class User < ActiveRecord::Base
  has_many :authentications
  has_many :gadgets
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nickname, :image
  
  
  #tem alguma diferenca entre criar o scope e o metodo para a busca. No scope nao tava retornando nil...
  module Scopes
    def por_login_social(nick)
      where("nickname = ?", nick).first
    end
  end
  
  extend Scopes

  def vai_no? evento
    return  Gadget.where(:evento_id => evento.id, :user_id => self.id).exists?
  end
end
