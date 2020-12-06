class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :role, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }


    enum role: { user: 'user', admin: 'admin', superadmin: 'superadmin'}
    has_many :tweets
    has_many :logs
  end