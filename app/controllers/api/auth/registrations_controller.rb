module Api
  module Auth
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      private

      def sign_up_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: {
            status: { code: 200, message: "Signed up successfully." },
            data: { id: resource.id, username: resource.username, email: resource.email }
          }, status: :ok
        else
          render json: {
            status: { message: "User couldn't be created. #{resource.errors.full_messages.to_sentence}" }
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
