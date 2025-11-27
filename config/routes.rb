Rails.application.routes.draw do
        devise_for :users,
                   path: "api/auth",
                   path_names: {
                     sign_in: "login",
                     sign_out: "logout",
                     registration: "signup"
                   },
                   controllers: {
                     sessions: "api/auth/sessions",
                     registrations: "api/auth/registrations"
                   }
  namespace :api do
     get "current_user", to: "users#current"
    resources :guns, only: [ :index, :show ]
    resources :attachments, only: [ :index, :show ]
    end


  get "/health", to: proc { [ 200, {}, [ "OK" ] ] }
end
