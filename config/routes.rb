Rails.application.routes.draw do
  post    'sessions' , to: 'session#user_login'
  resources :users
  
end
