Rails.application.routes.draw do
  #devise route 관련
  devise_for :users
  
  root 'posts#index'
  get '/like/:id' => 'posts#like'
  #CRUD중 C관련
  get 'posts/new'

  post 'posts/create' => 'posts#create'

  #CRUD중 R관련

  get 'posts/show/:id' => 'posts#show'

  #CRUD중 U관련
  get 'posts/edit/:id' => 'posts#edit'

  post 'posts/update/:id' => 'posts#update'
  patch 'posts/update/:id' => 'posts#update'

  #CRUD중 D관련
  get 'posts/destroy/:id' => 'posts#destroy'
  delete 'posts/destroy/:id' => 'posts#destroy'
  
  get '/after_login' => 'posts#after_login'
  get '/mine' => 'posts#mine'
  get '/tag' => 'posts#tag'
  
  post '/posts/expired' => 'posts#expired'
  get '/posts/ex_things'
  
    #메일건 관련
  get '/newmail' => 'posts#newmail'
  
  post '/sending' => 'posts#sending'
  
  
  resources :follows, only: [:create, :destroy]
  
  get 'posts/follow' => 'posts#follow'
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
