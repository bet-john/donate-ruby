Rails.application.routes.draw do
  post    'sessions' , to: 'session#user_login'
  post    'forgot-password', to: 'forgot_password#sent_password_email'
  resources :users

end
