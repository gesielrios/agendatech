# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def tab_link_to(caption, url)
    match = params[:controller] == url[:controller]
    match &&= params[:action] == url[:action] if url[:action]
    klass = match ? 'menu_select' : 'menu_inicial'
    link_to caption, url, {:class => klass}
  end
end


