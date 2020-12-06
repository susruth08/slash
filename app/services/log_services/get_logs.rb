module LogServices
    class GetLogs
        def initialize(current_user: current_user, status: status)
            @current_user = current_user
            @status = status
        end
    
        def execute
            result = []
            log_details = LogDetail.all
            return OpenStruct.new(success?: true, log_details: log_details, errors: nil)
        end
    end
end

