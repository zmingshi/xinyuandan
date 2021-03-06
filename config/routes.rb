Xinyuandan::Application.routes.draw do

  resources :friendships
  
  resources :wish_items

  controller :sessions do
    get 'login' => :new
	post 'login' => :create
	delete 'logout' => :destroy
  end

  controller :users do
    get 'search'  => :finduser
	post 'search' => :search
  end

  get "sessions/create"
  get "sessions/destroy"
  resources :users

  resources :users do
    resources :wish_items
  end  
 
  get 'allitems' => 'wish_items#allindex'
  get 'users/:id/items' => 'wish_items#item', as: :user_items
  get 'wish_items/:id/setflag' => 'wish_items#set_flag'

  resources :users do
    resources :friendships
  end  
  #resources :friendships,  only: [:create, :destroy]

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
