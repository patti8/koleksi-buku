Rails.application.routes.draw do
  devise_for :users


  mount BooksApi::Base => '/api'
  mount ActionCable.server => '/cable'

  get "up" => "rails/health#show", as: :rails_health_check

  get '/', to: 'books#index'
  post '/add_book', to: 'books#create', defaults: {format: :json}

end
