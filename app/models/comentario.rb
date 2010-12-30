class Comentario < ActiveRecord::Base
  belongs_to :evento
  
  scope :ultimos, includes(:evento).order("created_at desc").limit(3)
end
