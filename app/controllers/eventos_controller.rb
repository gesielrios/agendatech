class EventosController < ApplicationController
  uses_tiny_mce :only => [:new,:create]

  def index
    if params[:month]
      @eventos = Evento.all(:conditions=> ["aprovado = ? AND #{SQL.mes_do_evento} = ? ", true,  numero_do_mes(params[:month])], :order => 'data ASC')
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
    @evento = Evento.find_by_cached_slug(params[:id])
    @comentario = Comentario.new
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

  def comentar
    @comentario = Comentario.new(params[:comentario])
    if @comentario.save
      flash[:comentario] = "Comentário cadastrado com sucesso!"
      @evento = Evento.find @comentario.evento_id
      @comentario = Comentario.new
      render :action => "show"
    else
      render :action => "new"
    end
  end

end
