class AdicionaSlugsCacheadosAosEventos < ActiveRecord::Migration
def self.up
    add_column :eventos, :cached_slug, :string
    add_index  :eventos, :cached_slug, :unique => true
  end

  def self.down
    remove_column :eventos, :cached_slug
  end
end
