Agendatech::Application.routes.draw do
  devise_for :admins
  namespace :admin do 
    root :to => 'admin#index'
    resources :eventos, :only => [:index] do
      member do
        get 'aprovar'
        get 'remover' 
      end
    end
    resources :grupos, :only => [:index, :destroy] do 
      member do
        put 'aprovar'
      end
    end
  end 

  match 'gadgets/:evento/:tipo' => 'gadgets#interagir', :as => :gadgets
  match 'rss/feed.:format' => 'rss#feed', :as => :feed
  match '/' => 'eventos#index'
  resources :eventos, :path_names => {:new => 'novo', :edit => 'editar'}
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

