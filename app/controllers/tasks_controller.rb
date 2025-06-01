class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  # current_userのタスク一覧を表示するメソッドはprivateないで定義し、各アクションが呼び出される前に
  # 実行する
  def index
    # gemfileのransackを追加したことにより。検索を行うためのransackメソッドが追加される。
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]) # 一覧表示の際にpageというscopeを適用してページネーションを行う。
    # @tasks = @q.result(distinct: true).recent
    # @q.resultは、ransackによる検索結果を返す。
    # distinct: trueは、重複するレコードを除外するオプション。
    # @q.resultはActiveRecord::Relationオブジェクトを返すので、さらにメソッドをチェーンして
    # recentスコープを適用することで、最新のタスクから順に取得できる。

    respond_to do |format| # format.htmlはHTMLとしてアクセスされた場合、format.csvはCSVとしてアクセスされた場合にそれぞれ実行される。
      format.html
      format.csv { send_data Task.generate_csv(@tasks), filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.csv" }
      # format.csvは、CSV形式でのレスポンスを処理する。
      # send_dataメソッドは、CSVデータをダウンロードさせるために使用される。
      # @tasks.generate_csvは、Taskモデルに定義されたgenerate_csvメソッドを呼び出してCSVデータを生成する。
      # filenameオプションは、ダウンロードされるファイルの名前を指定する。
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました"
  end

  def destroy
    binding.irb
    @task.destroy
    redirect_to tasks_url, notice: "タスクを削除しました"
  end

  def create
   @task = current_user.tasks.new(task_params)
    if params[:back].present?
      render :new
      return # このreturnは、if節が成功した場合にnewのフォームを再表示するために必要。
    end

    # @taskとすることでif節が失敗した時にレンダリングされるnewのフォームに前回の入力データが引き継がれる
    if @task.save
      TaskMailer.creation_email(@task).deliver_now
       SampleJob.perform_later
      # タスクが作成されたときにメールを送信する。
      # deliver_nowメソッドは、メールを即時に送信することを意味する。
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
    # @task.valid?は、@taskのバリデーションを実行し、エラーがあればfalseを返す。
    # そのため、エラーがあればnewのフォームを再表示する。
    # @task.valid?がtrueならば、confirm_newのビューを表示する。
    # confirm_newのビューは、タスク登録の確認画面となる。
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクをインポートしました"
  end

  private
    def task_params
      params.require(:task).permit(:name, :description, :image)
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end
end
