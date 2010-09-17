class Grupo < ActiveRecord::Base
  has_many :eventos

  acts_as_taggable
  has_attached_file :logo, :styles => { :medium => "195x189>", :thumb => "97x97>" }
  validates_presence_of :nome
  validates_presence_of :site
  validates_uniqueness_of :nome

  attr_accessible :logo, :nome, :tag_list, :site

  named_scope :nao_aprovados, :conditions => { :aprovado => false }
  named_scope :aprovados, :order => 'nome ASC',:conditions => { :aprovado => true }
  named_scope :por_nome, :order => 'nome ASC'

  def aprovar!
    update_attribute(:aprovado, true)
  end

  def reprovar!
    update_attribute(:aprovado, false)
  end
end
