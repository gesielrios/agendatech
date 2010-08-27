class Grupo < ActiveRecord::Base
  acts_as_taggable
  has_attached_file :logo, :styles => { :medium => "195x189>", :thumb => "97x97>" }
  validates_presence_of :nome
  validates_uniqueness_of :nome

  attr_accessible :logo, :nome, :tag_list

  named_scope :nao_aprovados, :conditions => { :aprovado => false }

  def aprovar!
    update_attribute(:aprovado, true)
  end

  def reprovar!
    update_attribute(:aprovado, false)
  end
end
