class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @project = current_user.projects.build if signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
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
end
