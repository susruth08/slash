class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.integer :log_type
      t.integer :operation_type
      t.references :user
      t.timestamps
    end
  end
end
