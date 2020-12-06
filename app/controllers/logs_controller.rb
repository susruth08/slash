class LogsController < ApplicationController
    before_action :authorize_request
    before_action :get_log_detail, only: [:mark]
    NotAuthorized = Class.new(StandardError)

    rescue_from NotAuthorized do |e|
        render json: {errors: [message: "403 Not Authorized"]}, status: 403
      end

    def index
        raise NotAuthorized unless LogPolicy.new(current_user: @current_user).can_view?
        log_response = LogServices::GetLogs.new(current_user: @current_user, status: params[:status]).execute
        response = LogSerializer.new(log_response.log_details).serializable_hash
        render json: {errors: nil, response: response}, status: 200
    end

    def mark
        raise NotAuthorized unless LogPolicy.new(current_user: @current_user).can_mark?
        if LogDetail.statuses[params[:status]] == LogDetail.statuses[:approved]
            log_response = LogServices::UpdateLogStatus::ApproveLog.new( current_user: @current_user, log_detail: @log_detail, status: params[:status]).execute
        elsif LogDetail.statuses[params[:status]] == LogDetail.statuses[:rejected]
            log_response = LogServices::UpdateLogStatus::RejectLog.new( current_user: @current_user, log_detail: @log_detail, status: params[:status]).execute
        end
        

    end
    private 

    def get_log_detail
        @log_detail = LogDetail.find_by(id: params[:id])
        render json: {errors: ["Log not found"], message: nil, response: nil}, status: 400 unless @log_detail.present?

    end

end
