module TweetServices
    class CreateTweet
        def initialize(current_user: current_user, tweet: tweet, user_id: nil)
            @current_user = current_user
            @tweet = tweet
            @user_id = user_id
        end
    
    
        def execute
            byebug
            @tweet.user=@current_user
            if @tweet.save
                return OpenStruct.new(success?: true, tweet: @tweet, errors: nil)
            else
                return OpenStruct.new(success?: false, tweet: nil, errors: @tweet.full_error_messages)
            end
        end

        
    end
end

