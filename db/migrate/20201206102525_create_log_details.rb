class CreateLogDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :log_details do |t|
      t.references :user
      t.references :log
      t.integer :status
      t.text :previous_version
      t.text :next_version
      t.timestamps
    end
  end
end
