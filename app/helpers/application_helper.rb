# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def tab_link_to(caption, url)
    match = params[:controller] == url[:controller]
    match &&= params[:action] == url[:action] if url[:action]
    klass = match ? 'menu_select' : 'menu_inicial'
    link_to caption, url, {:class => klass}
  end
  
  def facebook_like_button
     raw %&<script src="http://connect.facebook.net/en_US/all.js#xfbml=1"></script><fb:like-box href="http://www.facebook.com/pages/Agendatech/190166907684709" width="230" show_faces="true" stream="true" header="true"></fb:like-box>&
  end
end


