module Api
  module Auth
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      def create
        build_resource(sign_up_params)

        resource.save
        yield resource if block_given?
        if resource.persisted?
          sign_up(resource_name, resource)
        else
          clean_up_passwords resource
          set_minimum_password_length
        end
        respond_with resource
      end

      private

      def sign_up(resource_name, resource)
        # Override to prevent auto sign-in (which uses sessions)
      end

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
