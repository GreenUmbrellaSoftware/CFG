Rails.application.routes.draw do
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :user_access_requests, :only => [:index]
  resources :users, :only => [:index, :edit, :update]
  resources :certificate_authorities, :only => [:index, :new, :show]
end
