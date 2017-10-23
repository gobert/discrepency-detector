Rails.application.routes.draw do
  post '/ads/status', to: 'ads#status'
end
