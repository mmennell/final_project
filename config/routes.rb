Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "restaurants#index"
  # Routes for the Job resource:
  # CREATE
  get "/jobs/new", :controller => "jobs", :action => "new"
  post "/create_job", :controller => "jobs", :action => "create"

  # READ
  get "/jobs", :controller => "jobs", :action => "index"
  get "/jobs/:id", :controller => "jobs", :action => "show"

  # UPDATE
  get "/jobs/:id/edit", :controller => "jobs", :action => "edit"
  post "/update_job/:id", :controller => "jobs", :action => "update"

  # DELETE
  get "/delete_job/:id", :controller => "jobs", :action => "destroy"
  #------------------------------

  # Routes for the Role resource:
  # CREATE
  get "/roles/new", :controller => "roles", :action => "new"
  post "/create_role", :controller => "roles", :action => "create"

  # READ
  get "/roles", :controller => "roles", :action => "index"
  get "/roles/:id", :controller => "roles", :action => "show"

  # UPDATE
  get "/roles/:id/edit", :controller => "roles", :action => "edit"
  post "/update_role/:id", :controller => "roles", :action => "update"

  # DELETE
  get "/delete_role/:id", :controller => "roles", :action => "destroy"
  #------------------------------

  # Routes for the Staff resource:
  # CREATE
  get "/staffs/new", :controller => "staffs", :action => "new"
  post "/create_staff", :controller => "staffs", :action => "create"

  # READ
  get "/staffs", :controller => "staffs", :action => "index"
  get "/staffs/:id", :controller => "staffs", :action => "show"

  # UPDATE
  get "/staffs/:id/edit", :controller => "staffs", :action => "edit"
  post "/update_staff/:id", :controller => "staffs", :action => "update"

  # DELETE
  get "/delete_staff/:id", :controller => "staffs", :action => "destroy"
  #------------------------------

  # Routes for the Restaurant resource:
  # CREATE
  get "/restaurants/new", :controller => "restaurants", :action => "new"
  post "/create_restaurant", :controller => "restaurants", :action => "create"

  # READ
  get "/restaurants", :controller => "restaurants", :action => "index"
  get "/restaurants/:id", :controller => "restaurants", :action => "show"

  # UPDATE
  get "/restaurants/:id/edit", :controller => "restaurants", :action => "edit"
  post "/update_restaurant/:id", :controller => "restaurants", :action => "update"

  # DELETE
  get "/delete_restaurant/:id", :controller => "restaurants", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
