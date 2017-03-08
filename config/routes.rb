Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :schedules
  resources :events
  resources :volunteers
  get 'registration/index'

  devise_for :users
  get 'welcome/index'
  get 'welcome/contact'
  get 'welcome/liveScores', to: 'welcome#liveScore'
  get 'welcome/upcoming', to: 'welcome#upcoming'

  get 'users/', to: 'welcome#index'

  # registration home page
  #get 'registration/index'

  # games viewing
  get 'game/', to: 'game#index'
  get 'game/:name', to: 'game#show'
  get 'game/:name/register', to: 'game#register'

  #games registration
  post 'game/:name/register/success' => "game#success"



  # profile viewing based on id
  get 'profiles/', to: 'profiles#index'
  get 'profiles/:id', to: 'profiles#show'

  # route to volunteer registration form
  get 'registration/volunteer_registration', to: 'registration#volunteer_registration'
  post 'registration/volunteer_registration', to: 'registration#volunteer_registration_process'

  # Admin panel
  get 'admin', to: 'admin#index'
  get 'admin/volunteers', to: 'admin#volunteers'
  post 'admin/volunteer_approve', to: 'admin#volunteer_approve'
  post 'admin/volunteer_disapprove', to: 'admin#volunteer_disapprove'
  get 'admin/massvolunteers', to: 'admin#massvolunteers'
  post 'admin/massvolunteersprocess', to: 'admin#massvolunteersprocess'

  get 'admin/registrations_individual', to: 'admin#registrations_individual'
  get 'admin/registrations_team', to: 'admin#registrations_team'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
