class GadgetsController < ApplicationController
  respond_to :json

  def create
      if user_signed_in?
        @gadget = Gadget.create :tipo => params[:tipo], :evento_id => params[:evento], :user_id => current_user.id
        respond_with @gadget
      else
        redirect_to '/auth/twitter'
      end  
  end
end
