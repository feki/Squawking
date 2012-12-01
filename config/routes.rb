RubyProject::Application.routes.draw do
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#welcome'

  match 'welcome', :to => 'pages#welcome'
  match 'home', :to => 'pages#home'

  devise_for :users

  resources :projects do
    member do
      # new article can be created only with associated project
      get '/articles/new', as: 'new_article_of', to: 'articles#new'

      # new question can be created only with associated project
      get 'questions/new', as: 'new_question_of', to: 'questions#new'
    end
  end

  resources :questions, except: :new
  resources :articles, except: :new

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:he preview action of PhotosController
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
