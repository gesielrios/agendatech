class Evento < ActiveRecord::Base
  acts_as_taggable
  has_attached_file :logo, :styles => { :medium => "195x189>", :thumb => "97x97>" }
  validates_presence_of   :nome, :site, :data, :descricao, :message => "Campo obrigatório"
    
  validates_date :data,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :if => Proc.new { |evento| !evento.aprovado }
  validates_format_of :site, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix    
end
