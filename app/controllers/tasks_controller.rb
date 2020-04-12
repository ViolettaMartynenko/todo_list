class TasksController < ApplicationController
  before_action :load_list, except: [:destroy, :edit, :update]
  before_action :set_task, only: [:edit, :update, :destroy, :completeness]


  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params.merge({list_id: params[:list_id]}))

    respond_to do |format|
      if @task.save 
        format.html { redirect_to list_path({id: @list.id}), notice: 'Task was successfully created.' }
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
        format.html { redirect_to list_url(id: @task.list_id), notice: 'Task was successfully updated.' }
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
      format.html { redirect_to list_url(id: @task.list_id), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH /lists/1/tasks/2/completeness
  def completeness
    task_completeness = @task.completeness
    @task.update(completeness: !task_completeness)
    message_notice = 
      if @task.completeness == true 
        {notice: "You have done it!"}
      else
        {notice: "Task is not completed"}
      end
    redirect_to(list_url(id: @task.list_id), message_notice)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def load_list
      @list = List.find params[:list_id]
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :list_id)
    end
end
