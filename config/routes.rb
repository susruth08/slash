Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  resources :tweets

  get '/logs', to: 'logs#index'
  post '/marklogs/:id', to: 'logs#mark'



  get '/*a', to: 'application#not_found'

  




  
end
