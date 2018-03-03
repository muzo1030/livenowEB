Rails.application.routes.draw do

	devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'videos#index'

  resources :videos do
  	collection do
  		get "search" => 'videos#search'
  	end
    resources :my_lists, only: [:create, :destroy]
  end

  resources :my_lists, only: [:index]

end
