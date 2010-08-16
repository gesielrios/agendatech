class Deixatodomundocomfimigualinicio < ActiveRecord::Migration
  def self.up
    eventos = Evento.find(:all) 
    eventos.each do |evento|
      unless evento.data_termino?
        Evento.update(evento.id,:data_termino => evento.data)
      end
    end
  end

  def self.down
  end
end
