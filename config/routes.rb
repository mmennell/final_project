Rails.application.routes.draw do
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
