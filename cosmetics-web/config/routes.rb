Rails.application.routes.draw do
  mount Shared::Web::Engine => '/', as: 'shared_engine'

  root 'landing_page#index'

  get '/manual_entry' => 'manual_entry#create'

  resources :notification_files

  resources :notifications, only: %i[edit] do
    member do
      get 'confirmation'
    end

    resources :manual_entry, only: %i[show update]
  end

  resources :responsible_persons do
    resources :notifications, controller: "responsible_persons/notifications"
    resources :team_members, controller: "responsible_persons/team_members"
  end
end
