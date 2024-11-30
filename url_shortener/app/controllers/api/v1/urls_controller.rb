class Api::V1::UrlsController < ApplicationController
  before_action :authenticate_token

  def create
    original_url = params[:original_url]
    puts "asdasdasdasd---11111-#{original_url}-"

    if original_url.blank?
      render json: { error: 'Original URL cannot be blank' }, status: :unprocessable_entity
      return
    end

    url = Url.new(original_url: original_url)

    if url.save
      render json: { short_url: redirect_url(url.short_url), original_url: url.original_url }, status: :created
    else
      render json: { error: url.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_token
    provided_token = request.headers['Authorization']&.split(' ')&.last

    if provided_token.blank? || !valid_token?(provided_token)
      render json: { error: 'Invalid or missing API token' }, status: :unauthorized
    end
  end

  def valid_token?(token)
    # Check the database for a valid token
    puts "--------env_token------#{token}"

    api_token = ApiToken.find_by(token: token)

    # Check if the token is valid and not expired
    return true if api_token && api_token.expires_at > Time.current

    # Check the .env API token as a fallback
    env_token = ENV['API_TOKEN']
    puts "--------env_token------#{env_token}-----------#{ActiveSupport::SecurityUtils.secure_compare(env_token, token)}"
    return true if env_token.present? && ActiveSupport::SecurityUtils.secure_compare(env_token, token)

    false
  end
end
