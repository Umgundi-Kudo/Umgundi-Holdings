module Kudos
    class Create
        def self.call(sender:, params:)
            new(sender, params).call
        end


        def initialize(sender:, params:)
            @sender = sender
            @params = params
        end

        def call
            kudo = Kudo.new(@params)
            kudo.sender = @sender

            if kudo.save
                success(kudo)
            else
                failure(kudo)
            end
        end

        private

        def sucess(kudo)
            OpenStruct.new(success?: true, kudo: kudo)
        end

        def failure(kudo)
            OpenStruct.new(success?: false, kudo: kudo)
        end
    end
end
