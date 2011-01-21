class MobileController < ApplicationController
  def eventos
    @eventos = Evento.que_ainda_vao_rolar
    render :json => @eventos
  end
  
  def novo_evento
    nome =  params[:nome]
    descricao = params[:descricao]
    site = params[:site]
    estado = params[:estado]
    data = params[:data]

    Evento.create :nome => nome, :descricao => descricao, :site => site, :estado => estado, :data => data, :aprovado => 0

    redirect_to :action => 'eventos'
  end
end
