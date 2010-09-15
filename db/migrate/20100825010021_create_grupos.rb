class CreateGrupos < ActiveRecord::Migration
  def self.up
    create_table :grupos do |t|
      t.string :nome
      t.boolean :aprovado, :default => false
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at

      t.timestamps
    end

    add_index :grupos, :nome, :unique => true
  end

  def self.down
    remove_index :grupos, :column => :nome

    drop_table :grupos
  end
end
