module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

      def find_verified_user
        token = request.params['token']
        decoded = JWT.decode(token, Rails.application.credentials.fetch(:secret_key_base))
        user_id = decoded.first.fetch('sub')
        User.find(user_id)
      rescue
        reject_unauthorized_connection
      end
  end
end
