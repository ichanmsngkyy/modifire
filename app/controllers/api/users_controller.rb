class Api::UsersController < ApplicationController
  before_action :authenticate_user!

    def current
      if current_user
        render json: current_user
      else
        render json: { error: "Not authenticated" }, status: :unauthorized
      end
    end
end
