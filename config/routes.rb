Photo::Application.routes.draw do

  get "moments/show"

  root :to => "home#index"

  devise_for :users,
             :path => "accounts",
             :path_names => {:sign_in => 'login',
                             :sign_out => 'logout',
                             :sign_up => 'join'}

  resources :people,
            :controller => 'Users',
            :only => [:show],
            :as => 'users' do
    resource :network, :only => [:show], :controller => 'network', :module => 'users'
    resource :settings, :only => [:show, :update], :module => 'users'
  end

  resources :experiences do
    resources :moments, :only => [:show] do
      get 'like', :on => :member
    end
  end

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
