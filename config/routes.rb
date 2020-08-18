Rails.application.routes.draw do
	root to: 'teams#index'
	resources :teams, only: [:create, :destroy]
	get '/:slug', to: 'teams#show'
	resources :channels, only: [:show, :create, :destroy]
	resources :talks, only: [:show]
	resources :team_users, only: [:create, :destroy]
	resources :invites, only: [:create]
	put '/invites/:id/accept', to: 'invites#accept'
	put '/invites/:id/reject', to: 'invites#reject'
	put '/invites/:id/disable', to: 'invites#disable'
	devise_for :users, :controllers => { registrations: 'registrations'}
	mount ActionCable.server => '/cable'
end
