Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :urls, only: [:create]
    end
  end

  # Frontend routes
  get '/shorten', to: 'frontend#new'
  post '/shorten', to: 'frontend#create'

  # Redirect short URLs
  get '/:short_url', to: 'redirects#show', as: :redirect
end
