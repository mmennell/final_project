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

    render("jobs/new.html.erb")
  end

  def create
    @job = Job.new

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
      when "/jobs/new", "/create_job"
        redirect_to("/jobs")
      else
        redirect_back(:fallback_location => "/", :notice => "Job created successfully.")
      end
    else
      render("jobs/new.html.erb")
    end
  end

  def edit
    @job = Job.find(params[:id])

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
        redirect_to("/jobs/#{@job.id}", :notice => "Job updated successfully.")
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

    if URI(request.referer).path == "/jobs/#{@job.id}"
      redirect_to("/", :notice => "Job deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Job deleted.")
    end
  end
end
