if Rails.env.production?
  OmniAuth.config.full_host = "http://sesh-ly.heroku.com"
else
  OmniAuth.config.full_host = "http://localhost:3000"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'heSDfAxaTN4rr5iBZfTNmA', 'RRxZ7KbepAx2D3VPqn7qpbbC20eGNqUBDmAd9OaqLA'
end
