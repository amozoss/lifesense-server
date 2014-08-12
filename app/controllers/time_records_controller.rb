class TimeRecordsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: [:destroy]

  def create
    project = current_user.projects.find_by(id: time_record_params[:project_id])
    @time_record = project.time_records.build(time_record_params)
    if @time_record.save
      flash[:success] = "Time record created!"
      redirect_to users_project_path(@time_record.project.user_id, @time_record.project_id)
    else
      render 'static_pages/home'
    end
  end

  def destroy
    uid = @time_record.project.user_id
    pid = @time_record.project_id
    @time_record.destroy
    redirect_to users_project_path(uid, pid)
  end

  private

    def time_record_params
      params.require(:time_record).permit(:description, :started_at, :ended_at, :project_id)
    end

    def correct_user
      @time_record = TimeRecord.find_by(id: params[:id])
      # check that the time record is part of the current user's projects
      render_404 if !current_user.projects.map(&:id).include? @time_record.project_id || @time_record.nil?
    end



end
