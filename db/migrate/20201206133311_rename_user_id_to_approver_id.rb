class RenameUserIdToApproverId < ActiveRecord::Migration[5.0]
  def change
    rename_column :log_details, :user_id, :approver_id
  end
end
