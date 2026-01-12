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

      ActiveRecord::Base.transaction do
        user.save!

        UserMailer.verify_email(user).deliver_now
      end

      OpenStruct.new(success?: true, user: user)

    rescue ActiveRecord::RecordInvalid => e
      OpenStruct.new(success?: false, error: e.record.errors.full_messages.first)

    rescue StandardError => e
      Rails.logger.error("USER REGISTER ERROR: #{e.message}")
      OpenStruct.new(success?: false, error: "Something went wrong. Please try again.")
    end
  end
end
