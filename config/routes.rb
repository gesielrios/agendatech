ActionController::Base.resources_path_names = { :new => 'novo', :edit => 'editar' }
ActionController::Routing::Routes.draw do |map|

  map.devise_for :admins

  map.namespace :admin, :path_prefix => 'admin' do |admin|
    admin.root :controller => 'admin'
    # TODO Arrumar os metodos HTTP
    admin.resources :eventos, :only => [:index], :member => {:aprovar => :get, :remover => :get}
    admin.resources :grupos, :only => [:index, :destroy], :member => {:aprovar => :put}
  end

	map.feed 'rss/feed.:format', :controller => 'rss', :action => 'feed'
  map.root :controller => "eventos"
  map.resources :eventos
  map.resources :comentarios
  
  map.calendario 'calendario/eventos', :controller => 'calendario', :action => 'index'
  map.calendario_por_estado 'calendario/eventos/:estado', :controller => 'calendario', :action => 'index'
  map.resources :grupos, :only => [:index, :new, :create]

  map.colaboradores 'colaboradores', :controller => "sobre", :action => "colaboradores"
  map.contato 'contato', :controller => "notifier"
  map.sobre 'sobre', :controller => "sobre"   
  map.calendario_link 'calendario', :controller => "calendario", :action => "links"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  #coloquei por ultimo para ter prioridade mais baixa...
  map.evento 'eventos/tecnologia/:ano/:id', :controller => 'eventos', :action => 'show'
  map.grupo 'grupos/:nome/:id/eventos', :controller => 'grupos', :action => 'show'

  map.eventos_por_estado 'busca/eventos/:estado', :controller => 'eventos', :action => 'index'
  map.eventos_por_mes 'busca/eventos/:ano/:month', :controller => 'eventos', :action => 'index'
end

