class GadgetsController < ApplicationController
  def interagir  
    gadget = Gadget.new :tipo => params[:tipo], :evento_id => params[:evento], :user_id => current_user
    gadget.save
    flash[:gadget] = "OK"
    redirect_to root_path    
  end
end
