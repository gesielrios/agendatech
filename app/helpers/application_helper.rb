# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def estados_com_eventos
    eventos = Evento.find_by_sql("select distinct estado from eventos where aprovado = 1 order by estado asc")    
    @estados = []    
    eventos.each do |e|
        @estados << e.estado
    end
    @estados    
  end
end


