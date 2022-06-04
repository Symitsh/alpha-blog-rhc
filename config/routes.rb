Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :articles

  root 'pages#home'
  get 'about', to: 'pages#about'

end
