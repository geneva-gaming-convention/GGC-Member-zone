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
    get     'users_groups'           => 'users_groups#index'
    get     'teams'                  => 'teams#list'
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
  get 'archived'                    =>  'events#archived',                      as: :events_archived
  resources :events,                only: [:index, :show] do
    resources :event_resources,     only: [:index, :show] do
      get 'teams'                   => 'event_resources#get_teams',             as: :teams
      get 'teams_and_players'       => 'event_resources#get_teams_and_players', as: :team_players
    end
    resources :registrations
  end
  # ---------------------------

  # Users Group & teams -------
  get     'users_groups'                                => 'users_groups#list',              as: :global_groups_list
  get     'teams'                                       => 'teams#global_list',               as: :global_teams_list
  resources :users_groups, except: :index do
    get     'join'                                      => 'users_groups#ask_to_join',       as: :ask_join
    get     'join/:token'                               => 'users_groups#join',              as: :token_join
    post    'join'                                      => 'users_groups#join',              as: :join
    get     'leave'                                     => 'users_groups#ask_to_leave',      as: :ask_to_leave
    delete  'leave'                                     => 'users_groups#leave',             as: :leave
    delete  'members/:id_member/kick'                   => 'users_groups#kick',              as: :kick_group_member
    get     'destroy'                                   => 'users_groups#ask_to_destroy',    as: :ask_to_destroy
    resources :teams do
      get     'join/:token'                               => 'teams#join',              as: :token_join
      post    'join'                                      => 'teams#join',              as: :join
      get     'leave'                                     => 'teams#ask_to_leave',      as: :ask_to_leave
      delete  'leave'                                     => 'teams#leave',             as: :leave
      delete  'team_members/:id_member/kick'              => 'teams#kick',              as: :kick_group_member
      get     'destroy'                                   => 'teams#ask_to_destroy',    as: :ask_to_destroy
    end
  end
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
  #namespace :admin do
  #  resources :users, except: [:show]
  #end
  # ---------------------------

end
