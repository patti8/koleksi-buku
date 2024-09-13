Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  get "up" => "rails/health#show", as: :rails_health_check

  get '/', to: 'books#index'
  get '/api/books', to: 'books#index', defaults: { format: :json }


  post '/add_book', to: 'books#create', defaults: {format: :json}

end
