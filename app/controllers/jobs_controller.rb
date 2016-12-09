class JobsController < ApplicationController
  def index
    @q = Job.ransack(params[:q])
    @jobs = @q.result(:distinct => true).includes(:staff, :role, :restaurant).page(params[:page]).per(10)

    render("jobs/index.html.erb")
  end

  def show
    @job = Job.find(params[:id])

    render("jobs/show.html.erb")
  end

  def new
    @job = Job.new
    @restaurant_id = params[:restaurant_id]

    render("jobs/new.html.erb")
  end

  def create
    # @restaurant_id = params[:restaurant_id]

    start = params[:start_time]
    finish = params[:end_time]

    x = params[:weeks].to_i
    #
    x.times do

      y = params[:times].to_i
      y.times do

        @job = Job.new

        @job.start_time = start
        @job.end_time = finish
        @job.role_id = params[:role_id]
        @job.hourly_rate = params[:hourly_rate]
        @job.staff_id = params[:staff_id]
        @job.approved = params[:approved]

        @job.save

      end
      start = (DateTime.parse(start) + 1.week).to_s
      # start = start + 1.week
      finish = (DateTime.parse(finish) + 1.week).to_s
    end

    # if save_status == true
    #   referer = URI(request.referer).path
    #
    #   case referer
    #   when "/jobs/new", "/create_job"
    #     redirect_to("/jobs")
    #   else
    #     redirect_back(:fallback_location => "/", :notice => "Job created successfully.")
    #   end
    # else
    @q = Job.ransack(params[:q])
    @jobs = @q.result(:distinct => true).includes(:staff, :role, :restaurant).page(params[:page]).per(10)

    redirect_to("/restaurants/#{@job.restaurant.id}")

  end

  def edit
    @job = Job.find(params[:id])
    @q = Staff.ransack(params[:q])
    @staffs = @q.result(:distinct => true).where(home_restaurant: @job.restaurant.id).includes(:user, :home_restaurant, :jobs).page(params[:staff]).per(10)
    @staffs_other  = @q.result(:distinct => true).where.not(home_restaurant: @job.restaurant.id).includes(:user, :home_restaurant, :jobs).page(params[:other]).per(10)

    render("jobs/edit.html.erb")
  end

  def update
    @job = Job.find(params[:id])

    @job.start_time = params[:start_time]
    @job.end_time = params[:end_time]
    @job.role_id = params[:role_id]
    @job.hourly_rate = params[:hourly_rate]
    @job.staff_id = params[:staff_id]
    @job.approved = params[:approved]

    save_status = @job.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/jobs/#{@job.id}/edit", "/update_job"
        redirect_to("/restaurants/#{@job.restaurant.id}", :notice => "Job assigned successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Job updated successfully.")
      end
    else
      render("jobs/edit.html.erb")
    end
  end

  def destroy
    @job = Job.find(params[:id])

    @job.destroy

    redirect_to("/restaurants/#{@job.restaurant.id}", :notice => "Shift Deleted")

    # if URI(request.referer).path == "/jobs/#{@job.id/edit}"
    #   redirect_to("/", :notice => "Job deleted.")
    # else
    #   redirect_back(:fallback_location => "/", :notice => "Job deleted.")
    # end
  end
end
