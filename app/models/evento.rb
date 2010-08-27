class Evento < ActiveRecord::Base
  belongs_to :grupo

  acts_as_taggable
  has_attached_file :logo, :styles => { :medium => "195x189>", :thumb => "97x97>" }
  validates_presence_of   :nome, :site, :data, :descricao, :message => "Campo obrigatório"
  validates_date :data,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :if => Proc.new { |evento| !evento.aprovado }
  validates_date :data_termino,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :allow_blank => true, :if => Proc.new { |evento| !evento.aprovado}
  validate :termino_depois_do_inicio?
  validates_format_of :site, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  named_scope :estado_aprovado, lambda { |estado| { :conditions => ["aprovado = ? AND estado = ?", true, estado], :order => 'data ASC' } }

  def termino_depois_do_inicio?
    if !errors.on(:data) && !errors.on(:data_termino) && data_termino && data_termino < data
       errors.add(:data_termino, 'O término deve vir após o inicio :)')
    end
  end

  public

  def ta_rolando?
    hoje = Date.today
    return data <= hoje && data_termino >= hoje
  end
end
