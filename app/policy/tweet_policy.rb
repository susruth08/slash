class TweetPolicy 
    attr_reader :current_user, :tweet

    def initialize(current_user: current_user, tweet: tweet)
        @current_user = current_user
        @tweet = tweet
    end

    def can_create?
        @current_user.user? || @current_user.admin?
    end

    def can_delete?
        @tweet.user == @current_user || @current_user.admin?
    end

    def can_update?
        @tweet.user == @current_user || @current_user.admin?
    end
end