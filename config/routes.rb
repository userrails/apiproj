Rails.application.routes.draw do

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'homes#index'
   resources :articles
   resources :authors

   # routes for api
  namespace :api do
    resources :articles, defaults: {format: :json}
    resources :authors 
  end  
  
  unauthenticated :user do
    devise_scope :user do
      post "api/users/sign_in", :to => "api/sessions#create"
      delete "api/users/sign_out", :to => "api/sessions#destroy"
      post "api/users/sign_up", :to => "api/registrations#create"
    end
  end

end