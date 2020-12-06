class TweetsController < ApplicationController
    before_action :authorize_request
    before_action :get_tweet, only: [:destroy, :update]
    NotAuthorized = Class.new(StandardError)

    rescue_from NotAuthorized do |e|
        render json: {errors: [message: "403 Not Authorized"]}, status: 403
      end

    def create
        tweet_policy = TweetPolicy.new(current_user: @current_user, tweet: nil)
        raise NotAuthorized unless tweet_policy.can_create?
        response = TweetServices::CreateTweet.new( current_user: @current_user, tweet: Tweet.new( tweet_params ) ).execute
        if response.success?
            log_response = LogServices::CreateLog.new(log: Log.new( logeable: response.tweet, log_type: Log.log_types[:action],  operation_type: Log.operation_types[:new_log] , user_id:  @current_user.id)).execute
            if log_response.success?
                LogServices::CreateLogDetail.new(log_detail: LogDetail.new( log_id: log_response.log.id,  next_version: response.tweet.to_yaml) ).execute
            end
            render json: {errors: nil, message: "success"}, status: 200
        else
            render json: {errors: tweet.errors, message: nil}, status: 400
        end
    end


    def index
        response  = TweetServices::GetTweets.new( current_user: @current_user).execute
        render json: {errors: nil, message: nil, response: response.tweets}, status: 200
    end

    def destroy
        raise NotAuthorized unless TweetPolicy.new(current_user: @current_user, tweet: @tweet).can_delete?
        response  = TweetServices::DeleteTweet.new( current_user: @current_user, tweet: @tweet).execute
        if response.success?
            log_response = LogServices::CreateLog.new(log: Log.new( log_type: Log.log_types[:audit],  operation_type: Log.operation_types[:delete_log] , user_id:  @current_user.id)).execute
            if log_response.success?
                LogServices::CreateLogDetail.new(log_detail: LogDetail.new( log_id: log_response.log.id,  previous_version: @tweet.to_yaml) ).execute
            end
            render json: {errors: nil, message: "Deleted succesfullt", response: response.tweets}, status: 200
        else
            render json: {errors: response.errors, message: nil, response: nil}, status: 400
        end
    end

    def update
        raise NotAuthorized unless TweetPolicy.new(current_user: @current_user, tweet: @tweet).can_update?
        response  = TweetServices::UpdateTweet.new( current_user: @current_user, tweet: @tweet, tweet_params: tweet_params.as_json() ).execute
        if response.success?
            render json: {errors: nil, message: nil, response: nil}, status: 200
        else
            render json: {errors: response.tweet.errors, message: nil, response: nil}, status: 400
        end
        
    end

    private

    def tweet_params
        params.permit(:title, :description)
    end

    def get_tweet
        @tweet = Tweet.find_by(id: params[:id])
        render json: {errors: ["Tweet not found"], message: nil, response: nil}, status: 400 unless @tweet.present?
    end
    
end
