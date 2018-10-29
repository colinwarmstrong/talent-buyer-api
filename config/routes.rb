Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  devise_for :buyers,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
  namespace :api do
    namespace :v1 do
      namespace :buyers do
        get '/:id/venues', to: 'venues#index'
        get '/:id/offers', to: 'offers#index'
        put '/:id/offers/:offer_id', to: 'offers#update'
      end
      resources :venues, only: [:create, :show]
      resources :offers, only: [:create]
      resources :artists, only: [:create, :index, :show]
      resources :shows, only: [:create]
    end
  end
end
