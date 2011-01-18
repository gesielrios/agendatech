class Evento < ActiveRecord::Base
  has_many :comentarios
  has_many :gadgets, :order => 'id desc' 
  belongs_to :grupo

  acts_as_taggable
  has_friendly_id :nome, :use_slug => true,:approximate_ascii => true
  Plugins.paper_clip self

  validates_presence_of   :nome, :site, :descricao, :message => "Campo obrigatório"
  validates_date :data,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :if => Proc.new { |evento| !evento.aprovado }
  validates_date :data_termino,:format=>"dd/mm/yyyy", :invalid_date_message => "Formato inválido", :allow_blank => true, :if => Proc.new { |evento| !evento.aprovado}
  validate :termino_depois_do_inicio?,:if => Proc.new { |evento| !evento.aprovado }
  validates_format_of :site, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  scope :nao_ocorrido, where("aprovado = ? AND ((? between data and data_termino) OR (data >= ?))",true, Date.today,Date.today)

  scope :aprovado, where("aprovado = ?",true)  
  
  scope :ordenado_por_data, order('data asc')

  scope :top_gadgets, includes(:gadgets)
  
  scope :para_o_ano, lambda {|ano| where("#{SQL.ano_do_evento} = ?",ano)}
  
      
  module Scopes
    
    def que_ainda_vao_rolar
      nao_ocorrido.ordenado_por_data
    end
    
    def agrupado_por_estado
        group('estado').aprovado.order('estado asc').count
    end
    
    def agrupado_por_mes
      group("#{SQL.mes_do_evento}").aprovado.para_o_ano(Time.now.year).order("#{SQL.mes_do_evento} asc").count
    end
    
    def ultimos_twitados
      select("distinct(twitter_hash)").aprovado.limit(3)      
    end
    
    def por_estado(estado)
      where("estado = ?",estado).aprovado.ordenado_por_data
    end
    
    def por_mes(mes)
      where("#{SQL.mes_do_evento} = ? ", mes).aprovado.ordenado_por_data
    end
  end
  
  extend Scopes
  
  private

  def termino_depois_do_inicio?
    if errors[:data].size == 0 && errors[:data_termino].size == 0 && data_termino && data_termino < data
      errors.add(:data_termino, 'O término deve vir após o inicio :)')
    end
  end
  

  public
  
  def me_da_gadgets
    GadgetDSL.new(self.gadgets)
  end

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

class GadgetDSL
  def initialize(gadgets)
    @gadgets = gadgets
  end
  
  def method_missing(tipo, *args, &block)  
     @gadgets.select {|gadget| gadget.tipo == Gadget.tipos[tipo]}       
  end  
end
