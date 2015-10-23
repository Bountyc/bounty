Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  post "pusher/auth"

  root "bounties#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }


  resources :bounties do
    member do
      get "add_working_user"
    end
  end
  resources :notifications do
    collection do
      put "see"
    end
  end
  resources :tags
  namespace :transfer do 
    resources :payments do 
      collection do 
        get "custom_action"
        get "create"
        post "start_payment"
      end
    end
    resources :withdrawals do
      collection do 
        post "create"
      end
    end
  end
  resources :answers do
    member do
      put "approve"
      put "deny"
    end
  end

  resources :disputes do
    member do
      put "moderate"
    end
  end

  resources :users

  namespace :api do
    resources :bounties, defaults: {format: :json}
    resources :messages, defaults: {format: :json}
    resources :disputes, defaults: {format: :json} do
      put "resolve"
    end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
