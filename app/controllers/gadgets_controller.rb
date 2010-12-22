class GadgetsController < ApplicationController
  respond_to :json

  def create
    if params[:tipo] == "EU_VOU"
      @gadget = Gadget.create :tipo => params[:tipo], :evento_id => params[:evento], :user_id => current_user.id

      respond_with @gadget
    end
  end
end
