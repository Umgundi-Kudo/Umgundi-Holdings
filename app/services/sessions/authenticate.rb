module Sessions
  class Authenticate
    def self.call(username:, password:)
      user = User.find_by(username: username)
      return unless user

      user.authenticate(password) ? user : nil
    end
  end
end
