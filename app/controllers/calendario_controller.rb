class CalendarioController < ApplicationController
def index
    
    if params[:estado]
      @eventos = Evento.estado_aprovado(params[:estado])
    else
      @eventos = Evento.all(:order => 'data ASC')
    end
    
    @calendar = Icalendar::Calendar.new
    
    for evento in @eventos
      event = Icalendar::Event.new
      event.start = Date.new(evento.data.year, evento.data.month, evento.data.day) #evento.data
      event.end = Date.new(evento.data_termino.year, evento.data_termino.month, evento.data_termino.day) + 1 #evento.data_termino
      event.summary = evento.nome
      event.description = evento.descricao
      @calendar.add event
    end
      
    @calendar.publish
    render :layout => false, :text => @calendar.to_ical
    
  end  

def link
  
end  
end
