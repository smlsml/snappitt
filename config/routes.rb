Photo::Application.routes.draw do

  root :to => "home#index"

  devise_for :users,
             :path => "accounts",
             :path_names => {:sign_in => 'login',
                             :sign_out => 'logout',
                             :sign_up => 'join'}

  resources :people,
            :controller => 'users',
            :only => [:index, :show],
            :as => 'users' do
    resource :settings, :only => [:show, :update], :module => 'users'
    resources :follow, :controller => 'follow', :module => 'users'
  end

  resources :experiences do
    collection do
      post 'create_mail'
    end

    resources :moments, :only => [:show, :destroy] do
      get 'publish', :on => :member
      get 'like', :on => :member
      get 'one', :on => :member
      get 'cover', :on => :member
      post 'comment', :on => :member
    end
  end

  resources :events, :only => [:index, :show, :create, :new]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
