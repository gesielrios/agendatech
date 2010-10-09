class CreateComentarios < ActiveRecord::Migration
  def self.up
    create_table :comentarios do |t|
      t.string :twitter
      t.text :descricao
      t.integer :evento_id
      t.timestamps
    end
  end

  def self.down
    drop_table :comentarios
  end

end
