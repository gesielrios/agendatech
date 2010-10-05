class EventosController < ApplicationController
  uses_tiny_mce :only => [:new,:create]

  def index
    if params[:month]
      @eventos = Evento.all(:conditions=> ["aprovado = ? AND month(data) = ? ", true,  numero_do_mes(params[:month])], :order => 'data ASC')
      @mes = params[:month]
    else
      if params[:estado]
        @eventos = Evento.estado_aprovado(estados.index(params[:estado]))
      else
        @eventos = Evento.nao_ocorrido
      end
    end
  end

  def new
    @evento = Evento.new
  end

  def create
    @evento = Evento.new(params[:evento])
    @evento.aprovado = false
    unless @evento.data_termino?
      @evento.data_termino = @evento.data
    end
    if @evento.save
      flash[:aguarde] = "Obrigado! Seu evento aparecerá na lista em instantes!"
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def show
    @evento = Evento.find(params[:id])
  end

  def tag
    @eventos = Evento.find_tagged_with(params[:id], :order => "data DESC")
    @tag = params[:id]
    render :action => "index"
  end

  def twits
    @evento = Evento.find_by_id(params[:id])
    render :layout => false
  end

end
