class CreateGadgets < ActiveRecord::Migration
  def self.up
    create_table :gadgets do |t|
      t.string :tipo
      t.integer :evento_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :gadgets
  end
end
