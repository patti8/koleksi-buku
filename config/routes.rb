Rails.application.routes.draw do

  mount BooksApi::Base => '/api'

  get "up" => "rails/health#show", as: :rails_health_check

  get '/', to: 'books#index'
  post '/add_book', to: 'books#create'

end
