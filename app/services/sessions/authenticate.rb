module Sessions
  class Authenticate
    def self.call(email: nil, username: nil, password:)
      new(email, username, password).call
    end

    def initialize(email, username, password)
      @email = email
      @username = username
      @password = password
    end

    def call
      user =
        if @email.present?
          User.find_by(email: @email)
        elsif @username.present?
          User.find_by(username: @username)
        end

      return nil unless user
      return nil unless user.authenticate(@password)
      return nil unless user.email_verified?

      user
    end
  end
end