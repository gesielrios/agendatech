require 'plugins'
require 'environment_hack'

class Evento < ActiveRecord::Base
  has_many :comentarios
  belongs_to :grupo

  acts_as_taggable
  has_friendly_id :nome, :use_slug => true,:approximate_ascii => true
  Plugins.paper_clip self
    
  validates_presence_of   :nome, :site, :data, :descricao, :message => "Campo obrigatório"
  validates_date :data,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :if => Proc.new { |evento| !evento.aprovado }
  validates_date :data_termino,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :allow_blank => true, :if => Proc.new { |evento| !evento.aprovado}
  validate :termino_depois_do_inicio?,:if => Proc.new { |evento| !evento.aprovado }
  validates_format_of :site, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  scope :estado_aprovado, lambda { |estado| { :conditions => ["aprovado = ? AND estado = ?", true, estado], :order => 'data ASC' } }

  scope :nao_ocorrido, {
    :conditions=> ["aprovado = ? AND ((? between data and data_termino) OR (data >= ?))  ", true, Date.today,Date.today],
    :order => 'data ASC'
  }

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
end
