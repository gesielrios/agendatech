class GruposController < ApplicationController
  def index
    @grupo = Grupo.new
  end

  def create
    @grupo = Grupo.new(params[:grupo])
    if @grupo.save
      respond_to do |format|
        format.html do
          flash[:aguarde] = 'Grupo registrado com sucesso. Seu grupo estará disponível em instantes.'
          redirect_to root_path
        end
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Erro no cadastro do grupo, por favor verifique os erros.'
          render :index
        end
      end
    end
  end
end
