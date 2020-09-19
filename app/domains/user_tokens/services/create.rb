require 'jwt'

module UserTokens
  module Services
    class Create
      def self.run(user)
        token = UserToken.new(
          token: generate_jwt(@user),
          user: user,
          expires_in: token_will_expires_in
        )

        if token.save
          return :created, token
        else
          return :failed, token
        end
      end

      private

      def self.generate_jwt(user)
        JWT.encode(
          { id: user, exp: token_will_expires_in },
          Rails.application.secrets.secret_key_base
        )
      end

      def self.token_will_expires_in
        (Time.now + 1.month).to_i
      end
    end
  end
end
