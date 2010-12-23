class GadgetsController < ApplicationController
  respond_to :json

  def create
      @gadget = Gadget.create :tipo => params[:tipo], :evento_id => params[:evento], :user_id => current_user.id
      respond_with @gadget
  end
end
