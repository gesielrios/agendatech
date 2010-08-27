class Admin::GruposController < ApplicationController
  admin_only

  def index
    @grupos = Grupo.nao_aprovados
  end

  def aprovar
    Grupo.update(params[:id], :aprovado => true)
    flash[:success] = "Grupo aprovado."
    redirect_to admin_grupos_path
  end

  def destroy
    Grupo.destroy params[:id]
    flash[:success] = "Grupo removido."
    redirect_to admin_grupos_path
  end

end
