module LogServices
    class CreateLogDetail
        def initialize(log_detail: log_detail)
            @log_details = log_detail
        end
    
        def execute
            if @log_details.save
                return OpenStruct.new(success?: true, log_detail: nil, errors: nil)
            else
                return OpenStruct.new(success?: false, tweet: nil, errors: @log_details.full_error_messages)
            end
        end
    end
end

