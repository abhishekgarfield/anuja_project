class Url < ApplicationRecord
  before_create :generate_short_url, :generate_token

  validates :original_url, presence: true, format: URI::regexp(%w[http https])

  private

  def generate_short_url
    self.short_url = SecureRandom.alphanumeric(6)
  end

  def generate_token
    self.token = SecureRandom.hex(10)
  end
end
