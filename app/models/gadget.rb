class Gadget < ActiveRecord::Base
  belongs_to :evento
  #aqui tem que trocar para o usuario com twitter.
  def self.tipos
    {:eu_vou => 'EU_VOU'}
  end    
end
