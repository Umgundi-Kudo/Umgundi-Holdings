module Kudos
  class KudoCreate
    attr_reader :kudo, :success

    def self.call(sender:, params:)
      new(sender, params).call
    end

    def initialize(sender, params)
      @sender = sender
      @params = params
      @kudo = nil
      @success = false
    end

    def call
      @kudo = Kudo.new(@params)
      @kudo.sender = @sender
      @success = @kudo.save
      self
    end

    def success?
      @success
    end
  end
end
