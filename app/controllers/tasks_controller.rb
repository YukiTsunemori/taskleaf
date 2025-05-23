class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = current_user.tasks.find(params[:id])
    # puts task.to_sql
    # binding.irb
  end

  def new
    @task = Task.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました"
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスクを削除しました"
  end

  def create
    @task = Task.new(task_params)
    # @taskとすることでif節が失敗した時にレンダリングされるnewのフォームに前回の入力データが引き継がれる
    if @task.save
      redirect_to @task
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
