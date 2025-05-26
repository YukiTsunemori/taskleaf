class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  # current_userのタスク一覧を表示するメソッドはprivateないで定義し、各アクションが呼び出される前に
  # 実行する
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました"
  end

  def destroy
    binding.irb
    @task.destroy
    redirect_to tasks_url, notice: "タスクを削除しました"
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    # @taskとすることでif節が失敗した時にレンダリングされるnewのフォームに前回の入力データが引き継がれる
    if @task.save
      logger.debug "task: #{@task.attributes.inspect}"
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :description)
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end
end
