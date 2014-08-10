class ProjectsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :show]
  before_action :correct_user,   only: [:show, :destroy]

  def show
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @project.destroy
    redirect_to root_url
  end

  private 

  def project_params
    params.require(:project).permit(:name)
  end

  def correct_user
    if  params[:project_id]
      @project = current_user.projects.find_by(id: params[:project_id])
    else
      @project = current_user.projects.find_by(id: params[:id])
    end
    render_404 if @project.nil?
  end
end
