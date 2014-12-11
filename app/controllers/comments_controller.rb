class CommentsController < ApplicationController

  before_action do
    @task = Task.find(params[:task_id])
    @project = Project.find(params[:project_id])
  end
  before_action :not_logged_in


  def create
    comment_params = params.require(:comment).permit(:task_id, :user_id, :description)
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      @comment.delete
      render "tasks/show"
    end
  end

end
