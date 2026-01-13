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
        UserMailer.verify_email(user).deliver_later
        success(user)
      else
        failure(user.errors.full_messages.first)
      end
    rescue StandardError => e
      Rails.logger.error("USER REGISTER ERROR: #{e.message}")
      failure("Something went wrong. Please try again.")
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
