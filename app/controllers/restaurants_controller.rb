class RestaurantsController < ApplicationController
  before_action :current_user_must_be_restaurant_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_restaurant_user
    restaurant = Restaurant.find(params[:id])

    unless current_user == restaurant.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Restaurant.ransack(params[:q])
    @restaurants = @q.result(:distinct => true).includes(:user, :staffs, :roles, :shifts).page(params[:page]).per(12)

    render("restaurants/index.html.erb")
  end

  def show
    @role = Role.new
    @staff = Staff.new
    @restaurant = Restaurant.find(params[:id])
    @staff_verified = @restaurant.staffs.where.not(verified: nil)
    @staff_unverified = @restaurant.staffs.where(verified: nil)

    @roles = Role.where(restaurant_id: @restaurant.id)
    @j = Job.ransack(params[:j])
    @shifts_a = @j.result(:distinct => true).where(role: @roles, staff: nil).includes(:staff, :role, :restaurant).page(params[:unassigned]).per(6).order(:start_time)
    @shifts_b = @j.result(:distinct => true).where(role: @roles, approved: TRUE).where.not(staff: nil).includes(:staff, :role, :restaurant).page(params[:upcoming]).per(6).order(:start_time)
    @shifts_c = @j.result(:distinct => true).where(role: @roles, approved: nil).where.not(staff: nil).includes(:staff, :role, :restaurant).page(params[:pending]).per(6).order(:start_time)

    render("restaurants/show.html.erb")
  end

  def new
    @restaurant = Restaurant.new

    render("restaurants/new.html.erb")
  end

  def create
    @restaurant = Restaurant.new

    @restaurant.restaurant_name = params[:restaurant_name]
    @restaurant.address = params[:address]
    @restaurant.latitude = params[:latitude]
    @restaurant.longitude = params[:longitude]
    @restaurant.description = params[:description]
    @restaurant.logo_url = params[:logo_url]
    @restaurant.contact_name = params[:contact_name]
    @restaurant.contact_telephone = params[:contact_telephone]
    @restaurant.user_id = params[:user_id]
    @restaurant.verified = params[:verified]

    save_status = @restaurant.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurants/new", "/create_restaurant"
        redirect_to("/restaurants")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant created successfully.")
      end
    else
      render("restaurants/new.html.erb")
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])

    render("restaurants/edit.html.erb")
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    @restaurant.restaurant_name = params[:restaurant_name]
    @restaurant.address = params[:address]
    @restaurant.latitude = params[:latitude]
    @restaurant.longitude = params[:longitude]
    @restaurant.description = params[:description]
    @restaurant.logo_url = params[:logo_url]
    @restaurant.contact_name = params[:contact_name]
    @restaurant.contact_telephone = params[:contact_telephone]
    @restaurant.user_id = params[:user_id]
    @restaurant.verified = params[:verified]

    save_status = @restaurant.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurants/#{@restaurant.id}/edit", "/update_restaurant"
        redirect_to("/restaurants/#{@restaurant.id}", :notice => "Restaurant updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant updated successfully.")
      end
    else
      render("restaurants/edit.html.erb")
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])

    @restaurant.destroy

    if URI(request.referer).path == "/restaurants/#{@restaurant.id}"
      redirect_to("/", :notice => "Restaurant deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Restaurant deleted.")
    end
  end
end
