Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Allow all origins or specify your frontend domain here
    resource '*',
      headers: :any,
      methods: [:get, :post, :options]
  end
end
