class Admin::EventosController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @eventos = Evento.all(:conditions=>{:aprovado=>false})
  end

  def aprovar
    Evento.update(params[:id], :aprovado => true)
    flash[:aprovado] = "Evento aprovado."
    render :action => 'index'
  end

  def remover
    Evento.destroy params[:id]
    flash[:removed] = "Evento removido."
    render :action => 'index'
  end

end
