class Admin::GruposController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @grupos = Grupo.nao_aprovados
    @grupos_editar = Grupo.all
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
  
  def editar
    @grupo = Grupo.find(params[:id])
  end
  
  def update
     @grupo = Grupo.find(params[:id])
      if @grupo.update_attributes(params[:grupo])
        flash[:notice] = "Grupo editado com sucesso"
        redirect_to :action => "index"
      else
        render :action => 'edit'
      end
  end
  

end
