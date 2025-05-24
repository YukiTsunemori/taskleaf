require "rails_helper"

RSpec.describe "タスク管理機能", type: :system do
  describe "一覧表示" do
    before do
      user_a = FactoryBot.create(:user, name: "ユーザーA", email: "a@example.com") # ユーザーAを作成しておく（テストデータの準備）
      # => buildメソッドをcreateの代わりに使えば、DBに登録する前で止めて未保存のオブジェクトを得ることができます。
      FactoryBot.create(:task, name: "最初のタスク", user: user_a) # 作成者がユーザーAであるタスクを作成しておく（テストデータの準備）
    end

    context "ユーザーAがログインしている時" do
      before do
        # ユーザーAでログインする
        visit login_path
        fill_in "メールアドレス", with: "a@example.com"
        fill_in "パスワード", with: "password"
        click_button "ログインする"
      end

      it "ユーザーAが作成したタスクが表示される" do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content "最初のタスク"
        # page(画面)に期待するよ、・・することを　　　#あるはずだよね、「最初のタスク」という内容が
      end
    end
  end
end
