# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth_v2', as: :auth_v2
  resources :vehicles
  root to: 'welcome#index'
  post '/', to: 'profiles#search', as: :search_profile
  get '/generate_graphic', to: 'welcome#generate_graphic', as: :generate_graphic
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'
end
