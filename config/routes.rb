ActionController::Base.resources_path_names = { :new => 'novo', :edit => 'editar' }
ActionController::Routing::Routes.draw do |map|

  map.devise_for :admins

	map.feed 'rss/feed.:format', :controller => 'rss', :action => 'feed'
  map.root :controller => "eventos"
  map.resources :eventos
  map.calendario 'calendario/eventos', :controller => 'calendario', :action => 'index'
  map.calendario_por_estado 'calendario/eventos/:estado', :controller => 'calendario', :action => 'index'
  map.resources :grupos, :only => [:index, :create, :show]
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  #coloquei por ultimo para ter prioridade mais baixa...
  map.evento 'eventos/:ano/:nome/:id', :controller => 'eventos', :action => 'show'
  map.eventos_por_estado 'busca/eventos/:estado', :controller => 'eventos', :action => 'index'
  map.eventos_por_mes 'busca/eventos/:ano/:month', :controller => 'eventos', :action => 'index'
end

