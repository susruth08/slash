class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login
  
    # POST /auth/login
    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        LogServices::CreateLog.new(log: Log.new( log_type: Log.log_types[:access],  operation_type: Log.operation_types[:signin] , user_id:  @user.id)).execute
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       username: @user.username }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
    
  
    private
  
    def login_params
      params.permit(:email, :password)
    end
  end
  