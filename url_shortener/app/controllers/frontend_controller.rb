class FrontendController < ApplicationController
  # POST /shorten
  def create
    # Get the original URL from the request parameters
    original_url = params[:url][:original_url]

    # Create a new Url object and attempt to save
    @url = Url.new(original_url: original_url)

    if @url.save
      # If the URL is saved, respond with a success message and the shortened URL
      render json: { short_url: redirect_url(@url.short_url) }, status: :created
    else
      # If the URL fails to save, return the error messages as JSON
      render json: { error: @url.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end
end
