class AddColumnSiteToGrupo < ActiveRecord::Migration
  def self.up
    add_column :grupos, :site, :string
  end

  def self.down
    remove_column :grupos, :site    
  end
end
