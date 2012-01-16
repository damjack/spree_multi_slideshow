Rails.application.routes.draw do

  namespace :admin do
      resources :slideshow_types do
        resources :slides
      end
  end
  
  resources :slides

  resources :slideshow_types

  # Add your extension routes here
end
