class ChangeTasksNameLimit30 < ActiveRecord::Migration[8.0]
  def up # カラムに追加する機能がある場合は、upメソッド
    change_column :tasks, :name, :string, limit: 30
  end

  def down # upメソッドで追加する機能をつける前のバージョンに戻す場合、rollbackが使える
    change_column :tasks, :name
  end
end
