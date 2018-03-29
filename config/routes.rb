Rails.application.routes.draw do

  jsonapi_resources :urls, only: [:index, :create]
  jsonapi_resources :contents, only: [:show]
  jsonapi_resources :links, only: [:show]
end
