module Api
  module V1
    class UrlsController < ApplicationController
      before_action :authenticate_token

      def create
        url = Url.new(url_params)
        if url.save
          render json: { short_url: redirect_url(url.short_url), token: url.token }, status: :created
        else
          render json: { error: url.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def url_params
        params.require(:url).permit(:original_url)
      end

      def authenticate_token
        puts "------ENV['API_TOKEN']----#{ENV['API_TOKEN']}"
        provided_token = request.headers['Authorization']&.split(' ')&.last
        render json: { error: 'Unauthorized' }, status: :unauthorized unless provided_token == ENV['API_TOKEN']
      end
    end
  end
end
