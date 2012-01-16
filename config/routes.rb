Rails.application.routes.draw do

  namespace :admin do
      resources :slideshow_types
      resources :slides
  end
  
end
