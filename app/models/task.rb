class Task < ApplicationRecord
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
