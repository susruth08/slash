class AddLogeableToLogs < ActiveRecord::Migration[5.0]
  def change
    add_reference :logs, :logeable, polymorphic: true
  end
end
