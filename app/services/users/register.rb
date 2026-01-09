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

      return failure("Invalid user details") unless user.valid?

      user.email_verification_token = SecureRandom.hex(20)
      user.email_verification_sent_at = Time.current

      user.save!

      UserMailer.email_verification(user).deliver_later

      success(user)
    rescue ActiveRecord::RecordInvalid => e
      failure(e.message)
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
