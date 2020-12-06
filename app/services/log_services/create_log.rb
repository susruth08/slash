module LogServices
    class CreateLog
        def initialize(log: log)
            @log = log
        end
    
        def execute
            if @log.save
                return OpenStruct.new(success?: true, log: @log, errors: nil)
            else
                return OpenStruct.new(success?: false, log: nil, errors: @log.full_error_messages)
            end
        end
    end
end

