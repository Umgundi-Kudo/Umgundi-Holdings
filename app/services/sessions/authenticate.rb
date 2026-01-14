module Sessions
  class Authenticate
    def self.call(email:, password:)
      user = User.find_by(email: email)

      unless user&.authenticate(password)
        return OpenStruct.new(
          success?: false,
          error: "Invalid email or password"
        )
      end

      unless user.email_verified?
        return OpenStruct.new(
          success?: false,
          error: "Please verify your email before logging in"
        )
      end

      OpenStruct.new(
        success?: true,
        user: user
      )
    end
  end
end
