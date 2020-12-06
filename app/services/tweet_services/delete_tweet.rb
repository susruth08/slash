module TweetServices
    class DeleteTweet
        def initialize(current_user: current_user, tweet: tweet)
            @current_user = current_user
            @tweet = tweet
        end
    
    
        def execute
            if @current_user.user?
                if @tweet.destroy
                    return OpenStruct.new(success?: true, tweet: nil, errors: nil)
                else
                    return OpenStruct.new(success?: false, tweet: nil, errors: ["Tweet could not be deleted"])
                end
            end
        end
    end
end

