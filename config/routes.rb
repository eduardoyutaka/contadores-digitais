Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/customers/new', to: 'customers#new'
  post '/customers', to: 'customers#create'
  post '/customers/upload', to: 'customers#upload'
end
