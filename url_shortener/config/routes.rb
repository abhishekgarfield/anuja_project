# Rails.application.routes.draw do
#   namespace :api do
#     namespace :v1 do
#       resources :urls, only: [:create]
#     end
#   end

#   # Frontend routes
#   get '/shorten', to: 'frontend#new'
#   post '/shorten', to: 'frontend#create'

#   # Redirect short URLs
#   get '/:short_url', to: 'redirects#show', as: :redirect
# end

Rails.application.routes.draw do
  # API Token generation routes
  resources :api_tokens, only: [:create]

  # Existing frontend routes
  get '/shorten', to: 'frontend#new'
  post '/shorten', to: 'frontend#create'

  # Redirect short URLs
  get '/:short_url', to: 'redirects#show', as: :redirect

  # API Routes for URL shortening (within namespace api/v1)
  namespace :api do
    namespace :v1 do
      resources :urls, only: [:create]
    end
  end
end
