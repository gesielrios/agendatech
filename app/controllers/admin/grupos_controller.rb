class Admin::GruposController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @grupos = Grupo.nao_aprovados
  end

  def aprovar
    Grupo.find(params[:id]).aprovar!
    flash[:notice] = "Grupo aprovado."
    redirect_to admin_grupos_path
  end

  def destroy
    Grupo.find(params[:id]).reprovar!
    flash[:notice] = "Grupo reprovado."
    redirect_to admin_grupos_path
  end

end
