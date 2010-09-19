class Admin::EventosController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @eventos = Evento.all(:conditions=>{:aprovado=>false})
  end

  def aprovar
    Evento.update(params[:id], :aprovado => true)
    flash[:notice] = "Evento aprovado."
    redirect_to :action => 'index'
  end

  def remover
    Evento.destroy params[:id]
    flash[:notice] = "Evento removido."
    redirect_to :action => 'index'
  end

end
