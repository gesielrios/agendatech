class MobileController < ApplicationController
  def eventos
    @eventos = Evento.nao_ocorrido
    render :json => @eventos
  end
  
  def novo_evento
    puts "recebeu!"
    puts params[:nome]
    redirect_to :action => 'eventos'
  end
end
