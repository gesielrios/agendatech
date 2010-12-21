class GadgetsController < ApplicationController
  def interagir  
    gadget = Gadget.new :tipo => params[:tipo], :evento_id => params[:evento], :user_id => current_user
    gadget.save
    flash[:gadget] = "OK"

    p "salvou....."

respond_to do |format|

   if request.xhr?

     p "eh xhr,...."
          format.html { render Evento.where(:id => params[:evento]).first, :layout => false}
        else
         format.html { redirect_to(event_url(event), :notice => 'You disliked the proposal.') }
       end
end
    #redirect_to root_path    
  end
end
