class Tweet < ApplicationRecord
  belongs_to :user,  required: true
  has_many :logs, as: :logeable
end
