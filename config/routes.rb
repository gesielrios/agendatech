Agendatech::Application.routes.draw do
#  namespace :admin do 
#    root :controller => 'admin' 
#    resources :eventos, :only => [:index], :member => {:aprovar => :get, :remover => :get} 
#    resources :grupos, :only => [:index, :destroy], :member => {:aprovar => :put} 
#  end 


  match 'admins' => 'admin/admin#index', :as => :devise_for
  match 'rss/feed.:format' => 'rss#feed', :as => :feed
  match '/' => 'eventos#index'
  resources :eventos
  root :to => 'eventos#index'
  resources :comentarios
  match 'calendario/eventos' => 'calendario#index', :as => :calendario
  match 'calendario/eventos/:estado' => 'calendario#index', :as => :calendario_por_estado
  resources :grupos
  match 'colaboradores' => 'sobre#colaboradores', :as => :colaboradores
  match 'contato' => 'notifier#index', :as => :contato
  match 'sobre' => 'sobre#index', :as => :sobre
  match 'calendario' => 'calendario#links', :as => :calendario_link
  match '/:controller(/:action(/:id))'
  match 'eventos/tecnologia/:ano/:id' => 'eventos#show', :as => :evento
  match 'grupos/:nome/:id/eventos' => 'grupos#show', :as => :grupo
  match 'busca/eventos/:estado' => 'eventos#index', :as => :eventos_por_estado
  match 'busca/eventos/:ano/:month' => 'eventos#index', :as => :eventos_por_mes

end

