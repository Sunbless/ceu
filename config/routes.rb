Zzjz::Application.routes.draw do

  get "imports/index"

  get "imports/import"

  resources :icds


  resources :agents


  resources :cases


  resources :phis


  resources :laboratories


  resources :hes


  resources :centers


  resources :districts


  devise_for :users, :path_prefix => 'my' do
    get "/my/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
    get "/my/users/sign_in" => "devise/sessions#new", :as => :new_user_session
    get "/my/users/sign_up" => "devise/sessions#new", :as => :new_user_registration #disable registration
    get '/my/users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    put '/my/users' => 'devise/registrations#update', :as => 'user_registration' 
    # get "users/sign_up", :to => "devise/sessions#new", :as => :sign_up
  end
  resources :users
  get "/users/type/:user_type" => "users#users_type", :as => :users_type


  get "/reports" => "reports#index", :as => :reports
  post "/reports" => "reports#make_report", :as => :reports
  post "/reports/sum" => "reports#make_sum_report", :as => :sum_reports

  get "/imports" => "imports#index", :as => :imports
  post "/imports" => "imports#import", :as => :imports

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'main#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
