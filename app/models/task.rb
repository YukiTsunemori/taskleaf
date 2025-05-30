class Task < ApplicationRecord
  def self.csv_attributes
    # CSV出力時に必要なカラムを指定する。
    # ここでは、4つのカラムをCSVに出力する。
    [ "name", "description", "created_at", "updated_at" ]
  end

  def self.generate_csv(tasks)
    ::CSV.generate(headers: true) do |csv|
      csv << csv_attributes # ヘッダー行を追加
      tasks.each do |task| # 全件を1件ずつ処理
        csv << csv_attributes.map { |attr| task.send(attr) } # 各タスクの属性値をCSV行として追加
      end
    end
  end

  def self.import(file) # fileという名前の引数でアップされたファイルの内容にアクセスするためのオブジェクトを受け取る
    CSV.foreach(file.path, headers: true) do |row|
      # CSV.foreachでファイルを1行ずつ読み込みます。headers: trueの指定で1行目のヘッダを無視する。
      task = new # 新しいTaskオブジェクトを生成 Task.new同じ。
      task.attributes = row.to_hash.slice(*csv_attributes)
      # row.to_hashでCSVの1行をハッシュに変換し、sliceメソッドでcsv_attributesに指定したカラムだけを抽出する。
      # これにより、CSVのヘッダと同じ名前のカラムだけがTaskオブジェクトに設定される。
      task.save!
    end
  end

  has_one_attached :image
  # has_one_attachedは、ActiveStorageを利用して画像を1つだけ添付できるようにする。
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma
  # 自分で定義したメソッドは、validate :メソッド名、(sは不要)とする。
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }
  # recentというスコープは、次のような使い方ができる。
  # tasks = Task.recent => 全件を新しい順に取得
  # task = Task.recent.first => 最も新しいタスクのオブジェクトを取得
  # Task.recentでActive::Relationオブジェクトを返すだけでクエリはまだ発行されない。
  # Railsのクエリ実行部分、つまりfirstを呼び出してそれがRelationオブジェクト（設計図のようなもの）
  # を呼び出すことでクエリが発行される。これはActicveRecordの遅延評価によるもの。

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "id", "id_value", "name", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    # ransackable_associationsは、検索に利用して良いカラムの範囲を制限できる
    []
  end


  private
    def validate_name_not_including_comma
        errors.add(:name, "にカンマを含めることはできません") if name&.include?(",")
    end
end
