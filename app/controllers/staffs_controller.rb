class StaffsController < ApplicationController
  # before_action :current_user_must_be_staff_user, :only => [:edit, :update, :destroy]
  #
  # def current_user_must_be_staff_user
  #   staff = Staff.find(params[:id])
  #
  #   unless current_user == staff.user
  #     redirect_to :back, :alert => "You are not authorized for that."
  #   end
  # end

  def index
    @q = Staff.ransack(params[:q])
    @staffs = @q.result(:distinct => true).includes(:user, :home_restaurant, :jobs).page(params[:page]).per(10)

    render("staffs/index.html.erb")
  end

  def show
    @q = Staff.ransack(params[:q])
    @staff = Staff.find(params[:id])
    @staffs = @q.result(:distinct => true).where(home_restaurant: @staff.home_restaurant, verified: TRUE).includes(:user, :home_restaurant, :jobs).page(params[:staff]).per(6).order(:first_name)

    @j = Job.ransack(params[:j])
    @jobs = @j.result(:distinct => true).where(staff: @staff.id, approved: TRUE).includes(:staff, :role, :restaurant).page(params[:schedule]).per(6).order(:start_time)
    @jobs_v = @j.result(:distinct => true).where(staff: @staff.id, approved: nil).includes(:staff, :role, :restaurant).page(params[:pending]).per(6).order(:start_time)


    @roles = Role.where(restaurant_id: @staff.home_restaurant_id)
    @jobs_a = @j.result(:distinct => true).where(staff: nil, role: @staff.role_id).includes(:staff, :role, :restaurant).page(params[:jobs]).per(6).order(:start_time)
    @jobs_b = @j.result(:distinct => true).where(staff: nil, role: @roles).includes(:staff, :role, :restaurant).page(params[:jobs_other]).per(6).order(:start_time)

    render("staffs/show.html.erb")

  end

  def new
    @staff = Staff.new


    render("staffs/new.html.erb")
  end

  def create


    @staff = Staff.new
    @staff.first_name = params[:first_name]
    @staff.last_name = params[:last_name]
    @staff.contact_telephone = params[:contact_telephone]
    @staff.avatar_url = params[:avatar_url]
    @staff.home_restaurant_id = params[:home_restaurant_id]
    @staff.role_id = params[:role_id]
    @staff.user_id = current_user.id
    @staff.verified = params[:verified]

    save_status = @staff.save


    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/staffs/new", "/create_staff"
        redirect_to("/restaurants")
      else
        redirect_back(:fallback_location => "/", :notice => "Staff created successfully.")
      end
    else
      render("staffs/new.html.erb")
    end
  end

  def edit
    @staff = Staff.find(params[:id])

    render("staffs/edit.html.erb")
  end

  def update
    @staff = Staff.find(params[:id])

    @staff.first_name = params[:first_name]
    @staff.last_name = params[:last_name]
    @staff.contact_telephone = params[:contact_telephone]
    @staff.avatar_url = params[:avatar_url]
    @staff.home_restaurant_id = params[:home_restaurant_id]
    @staff.role_id = params[:role_id]
    @staff.user_id = params[:user_id]
    @staff.verified = params[:verified]

    save_status = @staff.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/staffs/#{@staff.id}/edit", "/update_staff"
        redirect_to("/restaurants/#{@staff.home_restaurant_id}", :notice => "Staff updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Staff updated successfully.")
      end
    else
      render("staffs/edit.html.erb")
    end
  end

  def destroy
    @staff = Staff.find(params[:id])

    @staff.destroy

    if URI(request.referer).path == "/staffs/#{@staff.id}"
      redirect_to("/", :notice => "Staff deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Staff deleted.")
    end
  end
end
