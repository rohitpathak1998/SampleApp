Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    get 'companies/index'
    get 'companies/create'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
