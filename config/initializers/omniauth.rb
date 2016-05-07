Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'xxqWT6qTwJj6L6PxiUtxNg', 'sBkX9qx7pCJpfVbErEJ6ygPpY5RGJQECbM0BQykri0'
  provider :twitter, 'L536Zxfv9prOjOnWTSLfOC2qK', 'HnIrC9TxB2qeM6m9qlIRXZKiQGIfyJwTt857ld2z1BY90AC96M'
end

OmniAuth.config.logger = Rails.logger
