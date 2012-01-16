Rails.application.routes.draw do

  namespace :admin do
      resources :slideshow_types do
        resources :slides
      end
  end
  
end
