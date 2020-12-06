class LogDetail < ApplicationRecord
    enum status: [:pending, :approved, :rejected]
    belongs_to :log
end
