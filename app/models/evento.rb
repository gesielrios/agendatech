class Evento < ActiveRecord::Base
  has_many :comentarios
  has_many :gadgets
  belongs_to :grupo

  acts_as_taggable
  has_friendly_id :nome, :use_slug => true,:approximate_ascii => true
  Plugins.paper_clip self

  validates_presence_of   :nome, :site, :descricao, :message => "Campo obrigatório"
  validates_date :data,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :if => Proc.new { |evento| !evento.aprovado }
  validates_date :data_termino,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :allow_blank => true, :if => Proc.new { |evento| !evento.aprovado}
  validate :termino_depois_do_inicio?,:if => Proc.new { |evento| !evento.aprovado }
  validates_format_of :site, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  scope :estado_aprovado, lambda { |estado| where("aprovado = ? AND estado = ?", true, estado).order('data ASC')}

  scope :por_mes, lambda{|mes| where("aprovado = ? AND #{SQL.mes_do_evento} = ? ", true,  numero_do_mes(mes)).order('data ASC')}

  scope :nao_ocorrido, where("aprovado = ? AND ((? between data and data_termino) OR (data >= ?))",true, Date.today,Date.today).order('data ASC')

  scope :top_gadgets, lambda {|tipo| includes(:gadgets).where('gadgets.tipo = ?',tipo)}

  private

  def termino_depois_do_inicio?
    if !errors.on(:data) && !errors.on(:data_termino) && data_termino && data_termino < data
      errors.add(:data_termino, 'O término deve vir após o inicio :)')
    end
  end

  public

  def ta_rolando?
    hoje = Date.today
    if data_termino.nil?
      return hoje == data.to_date
    end
    hoje.between?(data.to_date, data_termino.to_date)
  end

  private

  def password_required?
    (authentications.empty? || !password.blank?) && (!persisted? || !password.nil? || !password_confirmation.nil?)
  end

  def email_required?
    authentications.empty?
  end
end
