Rails.application.routes.draw do

  # Welcome -------------------
  root  'welcome#index'
  get   'commits'                    => 'welcome#get_commits'
  get   'jsevents'                   => 'welcome#get_events'
  # ---------------------------

  # Users ---------------------
  resources :users do
    get     'delete'                 => 'users#delete'
    put     'phone'                  => 'users#update_phone'
    delete  'phone'                  => 'users#delete_phone'
    get     'ask_validation'         => 'users#ask_validation'
    resources :battlenet_accounts,   only: [:destroy]
    resources :steam_accounts,       only: [:destroy]
    resources :users_groups do
      get 'leave'                    => 'users_groups#leave'
    end
  end
  get   'validate/:token'            => 'users#validate',                       as: :validate
  # ---------------------------

  # Reset password ------------
  get   'reset_password'             => 'reset_password#ask_reset_password',    as: :ask_rst_passwd
  post  'send_new_password'          => 'reset_password#send_new_password',     as: :send_new_passwd
  get   'config_new_password/:token' => 'reset_password#config_new_password',   as: :conf_new_passwd
  patch 'reset_password/:token'      => 'reset_password#reset_password',        as: :rst_passwd
  # ---------------------------

  # Addresses -----------------
  resources :addresses
  post 'validate_addr'               => 'addresses#get_valid_addr'
  # ---------------------------

  # Game accounts -------------
  resources :battlenet_accounts,    only: [:new, :auth_callback]
  resources :steam_accounts,        only: [:new, :auth_callback]
  get 'auth/bnet/callback'          => 'battlenet_accounts#auth_callback'
  post 'auth/bnet/callback'         => 'battlenet_accounts#auth_callback'
  get 'auth/steam/callback'         => 'steam_accounts#auth_callback'
  post 'auth/steam/callback'        => 'steam_accounts#auth_callback'
  get '/auth/failure'               => 'users#auth_failure'
  # ---------------------------

  # Events --------------------
  resources :events,                only: [:index, :show] do
    resources :event_resources,     only: [:index, :show] do
      get 'teams'                   => 'event_resources#get_teams',             as: :teams
      get 'teams_and_players'       => 'event_resources#get_teams_and_players', as: :team_players
    end
  end
  # ---------------------------

  # Users Group ---------------
  get     'users_groups'                   => 'users_groups#list',              as: :global_groups_list
  get     'users_groups/:id'               => 'users_groups#show',              as: :show_group
  get     'users_groups/:id/ask_to_join'   => 'users_groups#ask_to_join',       as: :ask_join_users_group
  post    'users_groups/:id/join'          => 'users_groups#join',              as: :join_users_group
  # ---------------------------

  # Statics pages -------------
  get     'faq'                            => 'static#faq'
  # ---------------------------

  # Sessions ------------------
  get     'login'                          => 'sessions#new'
  post    'login'                          => 'sessions#create'
  delete  'logout'                         => 'sessions#destroy'
  # ---------------------------

  # Admin ---------------------
  namespace :admin do
    resources :users, except: [:show]
  end
  # ---------------------------

end
