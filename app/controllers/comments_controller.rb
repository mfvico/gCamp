class CommentsController < ApplicationController

  before_action do
    @task = Task.find(params[:task_id])
    @project = Project.find(params[:project_id])
  end


  def create
    comment_params = params.require(:comment).permit(:task_id, :user_id, :description)
    @comment = @task.comments.new(comment_params)
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      render :show
    end
  end

end
