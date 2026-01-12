module Sessions
  class Authenticate
    def self.call(email:, password:)
      new(email, password).call
    end

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      user = User.find_by(email: @email)

      return failure("Invalid email or password") unless user&.authenticate(@password)
      return failure("Please verify your email before logging in") unless user.email_verified

      success(user)
    end

    private

    def success(user)
      OpenStruct.new(success?: true, user: user)
    end

    def failure(message)
      OpenStruct.new(success?: false, error: message)
    end
  end
end
