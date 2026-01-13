module Sessions
  class Authenticate
    def self.call(username:, password:)
      new(username, password).call
    end

    def initialize(username, password)
      @username = username
      @password = password
    end

    def call
      user = User.find_by(username: @username)
      return nil unless user
      return nil unless user.authenticate(@password)
      return nil unless user.email_verified?

      user
    end
  end
end
