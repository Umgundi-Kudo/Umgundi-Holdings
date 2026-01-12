module Users
  class VerifyEmail
    def self.call(token)
      new(token).call
    end

    def initialize(token)
      @token = token
    end

    def call
      user = User.find_by(email_verification_token: @token)
      return failure("Invalid or expired verification link.") unless user

      user.update!(
        email_verified: true,
        email_verification_token: nil,
        email_verification_sent_at: nil
      )

      success
    end

    private

    def success
      OpenStruct.new(success?: true)
    end

    def failure(message)
      OpenStruct.new(success?: false, error: message)
    end
  end
end
