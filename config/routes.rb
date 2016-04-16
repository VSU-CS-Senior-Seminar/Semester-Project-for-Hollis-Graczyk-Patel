Rails.application.routes.draw do
  resources :event_comments
  resources :feeds
  resources :blog_articals
  resources :events
  resources :emails
  resources :business_messages
  resources :group_messages
  resources :private_messages
  resources :memberships
  resources :groups
  resources :messages do
    resources :comments
    member do
      put "like" => "messages#upvote"
      put "unlike" => "messages#downvote"
    end
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :destroy_user
  
  get 'feed' => 'blog_articles#feed'
  get 'webhook' => 'feeds#webhook'
  post 'webhook' => 'feeds#webhook' 
  get 'subscribe' => 'feeds#subscribe'
  get 'home/index'
  get 'home/profile'
  get 'home/calendar'
  get 'home/leadCandidates'
  get 'home/currentLeads'
  get 'home/userDirectory'
  post 'home/promote'
  post 'home/demote'
  
  
  root 'home#index', as: 'home' 

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
