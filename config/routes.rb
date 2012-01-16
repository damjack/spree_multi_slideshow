Rails.application.routes.draw do

  map.namespace :admin do
      resources :slideshow_types
      resources :slides
  end
  
end
