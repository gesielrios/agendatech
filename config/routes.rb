ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "eventos"
  map.resources :eventos
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  #coloquei por ultimo para ter prioridade mais baixa...
  map.evento 'eventos/:ano/:nome/:id', :controller => 'eventos', :action => 'show'  
  map.eventos_por_estado 'busca/eventos/:estado', :controller => 'eventos', :action => 'index'
  map.eventos_por_mes 'busca/eventos/:ano/:month', :controller => 'eventos', :action => 'index'
end  

