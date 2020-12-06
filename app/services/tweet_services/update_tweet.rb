module TweetServices
    class UpdateTweet
        def initialize(current_user: current_user, tweet: tweet, tweet_params: nil)
            @current_user = current_user
            @tweet = tweet
            @tweet_params = tweet_params
        end
    
    
        def execute
            if @current_user.user?
                if @tweet.destroy
                    return OpenStruct.new(success?: true, tweet: nil, errors: nil)
                else
                    return OpenStruct.new(success?: false, tweet: nil, errors: ["Tweet could not be deleted"])
                end
            else
                log_response = LogServices::CreateLog.new(log: Log.new( log_type: Log.log_types[:action],  operation_type: Log.operation_types[:update_log] , user_id:  @current_user.id, logeable_id: @current_user.id, logeable_type: @current_user.class)).execute
                if log_response.success?
                    previous_version =  @tweet.as_json.to_yaml
                    @tweet.title = @tweet_params["title"]
                    @tweet.description = @tweet_params["description"]
                    next_version =  @tweet.as_json.to_yaml
                    log_detail_response = LogServices::CreateLogDetail.new(log_detail: LogDetail.new( log_id: log_response.log.id,  previous_version: previous_version, next_version: next_version, status: LogDetail.statuses[:pending]) ).execute

                    if log_detail_response.success?
                        return OpenStruct.new(success?: true, tweet: nil, errors: nil)
                    else
                        return OpenStruct.new(success?: false, tweet: nil, errors: log_detail_response.errors)
                    end
                else
                    return OpenStruct.new(success?: false, tweet: nil, errors: log_response.errors)
                end
            end
        end
    end
end

