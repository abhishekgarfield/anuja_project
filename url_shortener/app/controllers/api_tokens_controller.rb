# app/controllers/api_tokens_controller.rb
class ApiTokensController < ApplicationController
  def create
    client_name = params[:client_name]

    if client_name.blank?
      render json: { error: 'Client name is required' }, status: :unprocessable_entity
      return
    end

    # Generate a unique token
    token = SecureRandom.hex(16)  # Generates a 32-character string
    api_token = ApiToken.create!(token: token, client_name: client_name, expires_at: 1.month.from_now)

    render json: { token: api_token.token, expires_at: api_token.expires_at }, status: :created
  end
end
