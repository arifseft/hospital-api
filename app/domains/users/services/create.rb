require 'jwt'

module Users
  module Services
    class Create
      def self.run(params)
        user = User.new(params)

        if user.save
          return :created, user, user.generate_jwt
        else
          return :failed, user, ''
        end
      end
    end
  end
end
