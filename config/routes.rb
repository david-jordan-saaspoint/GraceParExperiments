SortableLists::Application.routes.draw do
 
  match "user/result"
  match "user/update"
   match "user/index"
   get "user/search"

  

 # get "welcome/index" => redirect("https://na12.salesforce.com/001/o")
  get "welcome/accountfieldlist"
  get "welcome/contactfieldlist"
  get "welcome/selectedfieldPersist"
  
  match "welcome/selectedcontactfield"
  match "welcome/selectedfieldPersist"
  match "welcome/selectedcontactfieldPersist"
  match  "welcome/fieldlist"  
  match "worksiteblock/paruser"
  match "paruser/dispcountry"
  match "worksiteblock/find_by_wn"
  match "worksiteblock/get_user_req" 
  match "welcome/selectedfield"
  match "worksiteblock/get_contacts"
  match "worksiteblock/show_more_records"
  match "worksiteblock/show_less_records"
  match "worksiteblock/show_more_details"
  match "worksiteblock/show_more_contactdetails"
  match "worksiteblock/show_contacts"
  match "worksiteblock/updateFromAccountPage"
  match "worksiteblock/fetch_duplicate_account"
  match "worksiteblock/handle_duplicate_records"
  match "worksiteblock/complete_contact_update"
  match "worksiteblock/updateFromContactPage"
 match "welcome/index"   
     match "welcome/contact_unsubscribe"
     match "welcome/account_unsubscribe"
# match "/updated" => redirect("https://na12.salesforce.com/001/o"), :as => :update
  resources :sfdctables
  resources :pardbs
  
 
 

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
   root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
