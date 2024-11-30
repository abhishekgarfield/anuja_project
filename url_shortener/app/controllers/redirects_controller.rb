class RedirectsController < ApplicationController
  def show
    url = Url.find_by(short_url: params[:short_url])

    if url
      # Use 'allow_other_host: true' to bypass the allowed hosts restriction (be cautious)
      redirect_to url.original_url, status: :moved_permanently, allow_other_host: true
    else
      render plain: 'URL not found', status: :not_found
    end
  end
end
