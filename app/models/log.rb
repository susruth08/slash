class Log < ApplicationRecord
    enum log_type: [:access, :action, :audit]
    enum operation_type: [:new_log, :read_log, :update_log, :delete_log, :signin, :signup]
    belongs_to :logeable, polymorphic: true
    belongs_to :user
    has_one :log_detail
end
