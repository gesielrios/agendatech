class NotifierController < ApplicationController
  
  def notifier
    contato = Contato.new params[:contato]
    Notifier.envia_email(contato)
    flash[:notice] = "Email enviado com sucesso. Obrigado!"
    redirect_to :controller => 'notifier'
  end

end
