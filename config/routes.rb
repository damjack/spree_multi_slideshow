Spree::Core::Engine.routes.draw do

  namespace :admin do
    resources :slideshows do
      resources :slides do
        collection do
          post :update_positions
        end
      end
    end
    
    resource :slide_settings
  end

end
