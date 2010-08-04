class CreateEventos < ActiveRecord::Migration
  def self.up
    create_table :eventos do |t|
      t.string :nome
      t.text :descricao
      t.string :site
      t.string :twitter
      t.string :twitter_hash
      t.boolean :aprovado
      t.datetime :data
      t.timestamps
    end
  end

  def self.down
    drop_table :eventos
  end
end
