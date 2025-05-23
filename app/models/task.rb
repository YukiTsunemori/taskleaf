class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma
  # 自分で定義したメソッドは、validate :メソッド名、(sは不要)とする。
  belongs_to :user
  private
    def validate_name_not_including_comma
        errors.add(:name, "にカンマを含めることはできません") if name&.include?(",")
    end

end
