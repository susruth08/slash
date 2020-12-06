module TweetServices
    class GetTweets
        def initialize(current_user: current_user)
            @current_user = current_user
        end
    
    
        def execute
            tweets=[]
            if @current_user.user?
                tweets = @current_user.tweets
            else
                tweets = Tweet.all
            end
            return OpenStruct.new(success?: true, tweets: tweets, errors: nil)
            
        end
    end
end

