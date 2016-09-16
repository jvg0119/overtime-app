Rails.application.routes.draw do

   resources :audit_logs, except: [:new, :edit, :destroy ] do 
      member do 
      #  post :confirm
      get :confirm
      end
   end

   namespace :admin do
     resources :users 
     resources :posts
     resources :admin_users
     resources :employees

     root to: "users#index"
   end
#  patch 'posts#update'

#  post 'posts/:id/approve' => 'posts#approve', as: 'approve_post'

  resources :posts do
    member do 
      post :approve
    #  get :approve
    end
  end


   devise_for :users, skip: [:registrations]
   root to: 'static#homepage'

  get 'rails/info/routes' # this needs to be on top to work otherwise it will be redirected
#  match '*path' => redirect('/'), via: :get



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
