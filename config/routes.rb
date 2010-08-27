ActionController::Base.resources_path_names = { :new => 'novo', :edit => 'editar' }
ActionController::Routing::Routes.draw do |map|

  map.devise_for :admins

  map.namespace :admin, :path_prefix => 'admin' do |admin|
    admin.root :controller => 'admin'
    # TODO Arrumar os metodos HTTP
    admin.resources :eventos, :only => [:index], :member => {:aprovar => :get, :remover => :get}
    admin.resources :grupos, :only => [:index, :update, :destroy]
  end

	map.feed 'rss/feed.:format', :controller => 'rss', :action => 'feed'
  map.root :controller => "eventos"
  map.resources :eventos
  map.resources :grupos, :only => [:index, :create, :show]
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  #coloquei por ultimo para ter prioridade mais baixa...
  map.evento 'eventos/:ano/:nome/:id', :controller => 'eventos', :action => 'show'
  map.eventos_por_estado 'busca/eventos/:estado', :controller => 'eventos', :action => 'index'
  map.eventos_por_mes 'busca/eventos/:ano/:month', :controller => 'eventos', :action => 'index'
end

