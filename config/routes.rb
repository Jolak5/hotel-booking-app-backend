Rails.application.routes.draw do
  # get 'root/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/hotel_name', to: 'hotel#hotel_name'
  # Defines the root path route ("/")
  # root "articles#index"
  root 'root#index'
end
