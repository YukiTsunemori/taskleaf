class ChangeTasksNameNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :tasks, :name, false 
    # change_column_nullは既存テーブルの既存カラムのNOT NULL制約を付けたり外したりすることができます。
    # 引数には、テーブル名、カラム名、true or falseをしているする。
  end
end
