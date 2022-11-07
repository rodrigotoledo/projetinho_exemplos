# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  root to: 'welcome#index'
  post '/', to: 'profiles#search', as: :search_profile
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
