# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  use_doorkeeper
  resources :vehicles
  root to: 'welcome#index'
  post '/', to: 'profiles#search', as: :search_profile
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      scope :users, module: :users do
        post '/', to: 'registrations#create', as: :user_registration
      end
      resources :vehicles
      namespace :mobile do
        resources :vehicles
      end
    end
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :authorizations, :applications, :authorized_applications
      end
    end
  end
end
