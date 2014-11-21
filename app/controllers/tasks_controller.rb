class TasksController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  @new_task = true

  # GET /tasks
  # GET /tasks.json
  def index

    if params[:sort_by] == "all"
      @tasks = @project.tasks.all
    else
      @tasks = @project.tasks.where(complete: false)
    end
    @task_csv = @project.tasks.order(:created_at)

    respond_to do |format|
      format.html
      format.csv { send_data @task_csv.as_csv }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = @project.tasks.find(params[:id])
    @comment = @task.comments.new
    @comments = @task.comments.all
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new

  end

  # GET /tasks/1/edit
  def edit

  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:task, :due_date, :complete)
    end
end
