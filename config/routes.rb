Rails.application.routes.draw do
  namespace :api do
    namespace :auth do
      devise_for :users,
                 path: "",
                 path_names: {
                   sign_in: "login",
                   sign_out: "logout",
                   registration: "signup"
                 },
                 controllers: {
                   sessions: "api/auth/sessions",
                   registrations: "api/auth/registrations"
                 }
    end
  end

  get "/health", to: proc { [ 200, {}, [ "OK" ] ] }
end
