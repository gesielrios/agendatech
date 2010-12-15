class Grupo < ActiveRecord::Base
  has_many :eventos

  acts_as_taggable
  Plugins.paper_clip self  


  validates_presence_of :nome
  validates_presence_of :site
  validates_uniqueness_of :nome

  attr_accessible :logo, :nome, :tag_list, :site

  scope :nao_aprovados, :conditions => { :aprovado => false }
  scope :aprovados, :order => 'nome ASC',:conditions => { :aprovado => true }
  scope :por_nome, :order => 'nome ASC'

  def aprovar!
    update_attribute(:aprovado, true)
  end

  def reprovar!
    update_attribute(:aprovado, false)
  end
end
