class Adddatafinaltoeventocolumn < ActiveRecord::Migration
  def self.up
      add_column :eventos, :data_termino, :datetime
  end

  def self.down
    remove_column :eventos, :data_termino
  end
end
