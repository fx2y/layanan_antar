Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, skip: :all
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post "users/sign_in", to: "sessions#create"
        delete "users/sign_out", to: "sessions#destroy"
      end

      resources :users, only: [ :create ] do
        collection do
          get :me
          put :me, to: "users#update"
        end
      end

      resources :service_templates
      resources :mitras do
        resources :service_instances
        resources :mitra_drivers
      end
    end
  end
end
