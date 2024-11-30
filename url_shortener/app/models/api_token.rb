# app/models/api_token.rb
class ApiToken < ApplicationRecord
  validates :token, presence: true, uniqueness: true
  validates :client_name, presence: true
  validates :expires_at, presence: true
end
