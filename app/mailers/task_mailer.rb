class TaskMailer < ApplicationMailer
  def creation_email(task) # taskはTaskオブジェクト。引数として受け取る。
    @task = task # メール本文作成のためにテンプレートで利用したいので、インスタンス変数へ代入する。
    mail(
      subject: "タスク作成完了メール",
      to: "user@example.com",
      from: "taskleaf@example.com"
    )
  end
  # creation_emailメソッドでは、メールの作成・送信を行うためのmailメソッドを呼び出す.
  # mailメソッドには、subjectやto、fromといった情報を指定する。
  # このメソッドは、タスクが作成されたときに呼び出されることを想定している。
  # メールの本文は、app/views/task_mailer/creation_email.html.erbに記述する。
end
