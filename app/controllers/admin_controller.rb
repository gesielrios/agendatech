class AdminController < ApplicationController

  def index
    @eventos = Evento.all(:conditions=>{:aprovado=>false})
  end
  
  def aprovar
    Evento.update(params[:id], :aprovado => true)
    flash[:aprovado] = "Evento aprovado."
    redirect_to :action => 'index'
  end
  
  def remover
    Evento.destroy params[:id]
    flash[:removed] = "Evento removido."    
    redirect_to :action => 'index'
  end
  
end
