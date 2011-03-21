class EventosController < ApplicationController
  uses_tiny_mce :only => [:new,:create]

  def index
    if params[:month]
      @eventos = Evento.por_mes(numero_do_mes(params[:month])).top_gadgets
    else
      if params[:estado]
        @eventos = Evento.por_estado(estados.index(params[:estado])).top_gadgets
      else
        @eventos = Evento.que_ainda_vao_rolar
      end
    end
  end

  def new
    @evento = Evento.new
  end

  def create
    @evento = Evento.new(params[:evento])
    @evento.aprovado = false

    @evento.data_termino = @evento.data unless @evento.data_termino?
    @evento.user = current_user if user_signed_in?

    if @evento.save
      flash[:aguarde] = "Obrigado! Seu evento aparecerá na lista em instantes!"
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def show
    debugger
    @evento = Evento.find_by_cached_slug(params[:id])
    @comentario = Comentario.new
  end

  def edit
    @evento = Evento.find_by_cached_slug(params[:id])
    unless @evento.pode_editar? current_user
      redirect_to :action => "index"
    end
  end

  def update
    debugger
    @evento = Evento.find_by_cached_slug(params[:id])
    unless @evento.pode_editar? current_user
      redirect_to :action => "index"
    else
      if @evento.update_attributes(params[:evento])
        flash[:notice] = "Evento editado com sucesso"
        redirect_to :action => "index"
      else
        render :action => 'edit'
      end
    end
  end

  def tag
    @eventos = Evento.find_tagged_with(params[:id], :order => "data DESC")
    @tag = params[:id]
    render :action => "index"
  end

  def comentar
    @comentario = Comentario.new(params[:comentario])
    @comentario.twitter = current_user.nickname
    if @comentario.save
      flash[:comentario] = "Comentário cadastrado com sucesso!"
      @evento = Evento.find_by_cached_slug(params[:evento_nome])
      redirect_to evento_path(:ano => @evento.data.year,:id=>@evento)
    else
      render :action => "new"
    end
  end

  def lista
    @participantes = []
    evento = Evento.find_by_cached_slug(params[:id])
    evento.gadgets.each do |g|
      @participantes << Twitter.user(User.find(g.user_id).nickname).name
    end
  end

  def meus_eventos
    if user_signed_in?
      @meus_eventos = current_user.eventos
    else
      redirect_to :action => "index"
    end
  end

end

