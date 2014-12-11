class TrackerProjectsController < ApplicationController

  def show
    tracker_api = TrackerAPI.new
    @tracker_stories = tracker_api.stories(current_user.tracker_token, params[:id])
    @tracker_projects = tracker_api.projects(current_user.tracker_token)
  end

end
