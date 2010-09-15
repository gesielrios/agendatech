class AddGrupoIdToEventos < ActiveRecord::Migration
  def self.up
    add_column :eventos, :grupo_id, :integer
  end

  def self.down
    remove_column :eventos, :grupo_id
  end
end
