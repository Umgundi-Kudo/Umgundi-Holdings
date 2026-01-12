module Users
  class Register
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      user = User.new(@params)
      user.email_verified = false
      user.email_verification_token = SecureRandom.hex(20)
      user.email_verification_sent_at = Time.current

      if user.save
        UserMailer.verify_email(user).deliver_now
        success
      else
        failure(user.errors.full_messages.first)
      end
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
