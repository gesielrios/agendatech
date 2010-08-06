class EventosController < ApplicationController
  uses_tiny_mce :only => :new

  def index    
    if params[:month]
      @eventos = Evento.all(:conditions=> ["aprovado = ? AND MONTH(data) = ? ", true,  numero_do_mes(params[:month])], :order => 'data ASC')      
      @mes = params[:month]
    else
      if params[:estado]
        @eventos = Evento.all(:conditions=> ["aprovado = ? AND estado = ? ", true,  estados.index(params[:estado])], :order => 'data ASC')      
      else    
        @eventos = Evento.all(:conditions=> ["aprovado = ? AND data >= ?", true, Date.today], :order => 'data ASC')
      end
    end 
    
    # implementacao as pressas pra aproveitar o oxenterails - refactor me , pls
    @images = []
    Twitter::Search.new('oxenterails').page(1).per_page(88).each do |r| 
      @images << r.profile_image_url
    end
    
    @ultimos_twits = []
    Twitter::Search.new('oxenterails').page(1).per_page(3).each do |r| 
      @ultimos_twits << r
    end
    
         
  end
  
  def new
    @evento = Evento.new
  end
  
  def create
    @evento = Evento.new(params[:evento])
    @evento.aprovado = false
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
  
end
