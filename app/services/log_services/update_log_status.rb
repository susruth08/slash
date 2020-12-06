module LogServices
    module UpdateLogStatus
        class ApproveLog
            def initialize(current_user: current_user, log_detail: log_detail, status: status)
                @current_user = current_user
                @log_detail = log_detail
                @status = status
            end
        
            def execute
                result = []
                @log_detail.update(status: @status)
                updated_data = YAML.load( @log_detail.next_version ).as_json
                tweet = Tweet.find(updated_data["id"])
                tweet.title = updated_data["title"]
                tweet.description = updated_data["description"]
                if tweet.save
                    return OpenStruct.new(success?: true, tweet: tweet, errors: nil)
                else
                    return OpenStruct.new(success?: false, log_details: log_details, errors: tweet.full_error_messages)
                end
            end

            private

            def update_tweet_data
                TweetServices::UpdateTweet.new(  )
            end
        end

        class RejectLog
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
    
end

