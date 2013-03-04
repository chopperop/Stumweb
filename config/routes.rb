Newstumweb::Application.routes.draw do

  resources :teams do
    resources :users
  end

  resources :users do
    get "new_message", :on => :collection
    post "create_message", :on => :collection
    delete "destroy_message", :on => :collection

    member do
      get 'likes'
      get 'dislikes'
      get 'messages'
      get 'inbox'
      get 'outbox'
      get 'show_message'
    end
  end

  resources :users do
    resources :comments
      end
  resources :sessions, :only => [:new, :create, :destroy]
  #resources :microposts, :only => [:create, :destroy]
  resources :photos do
    member do
      get 'like'
      get 'dislike'
    end
  end

  resources :password_resets

  resources :photos do
    resources :comments do
     get 'reply', :on => :collection
   end
 end

  resources :contents do
    member do
      get 'like'
      get 'dislike'
    end
  end


  resources :contents do
    resources :comments do
     get 'reply', :on => :collection
   end
 end

 resources :comments do
  member do
    get 'like'
    get 'dislike'
  end
end

  resources :photos do
    resources :captions 
  end

  root :to => "pages#home"

  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  match '/contest', :to => 'pages#contest'
  match '/bestfeatures', :to => 'pages#bestfeatures'
  match '/index', :to => 'users#index'
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/sessions', :to => 'sessions#create'
  match '/signout', :to => 'sessions#destroy'
  match '/comments', :to => 'comments#create'
  match '/contents', :to => 'contents#index'
  match '/contents/:id', :to => 'contents#show'
  match '/contents/:content_id/comments', :to => 'comments#index'
  match '/photos/:photo_id/comments', :to => 'comments#index'
  match '/contents/:content_id/comments/reply', :to => 'comments#reply'
  match '/results', :to => 'contents#index'
  #match '/photos/:photo_id/comments/:id', :to => 'comments#destroy'
  #match '/photos/:id', :to => 'photos#show'
  #match '/photos/:photo_id/comments', :to => 'comments#index'
  match '/newteam', :to => 'teams#new'
  match '/jointeam', :to => 'teams#join'


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
