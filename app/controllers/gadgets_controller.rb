class GadgetsController < ApplicationController
  def interagir
    p "hey ho"

    gadget = Gadget.new :tipo => params[:tipo], :evento_id => params[:evento], :user_id => 1
    gadget.save
    flash[:gadget] = "OK"
    redirect_to root_path
    
  end
end
