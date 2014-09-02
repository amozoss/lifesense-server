class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @project = current_user.projects.build if signed_in?
      @projects = current_user.projects.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def meeting
  end

  def milestones
  end
end
