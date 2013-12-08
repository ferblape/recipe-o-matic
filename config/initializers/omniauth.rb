Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'xxqWT6qTwJj6L6PxiUtxNg', 'sBkX9qx7pCJpfVbErEJ6ygPpY5RGJQECbM0BQykri0'
end

OmniAuth.config.logger = Rails.logger
