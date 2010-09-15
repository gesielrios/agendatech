class GruposController < ApplicationController
  def index
    @grupos = Grupo.por_nome.aprovados
  end

  def new
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
          render :new
        end
      end
    end
  end
end
