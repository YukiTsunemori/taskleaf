require "rails_helper"

RSpec.describe "タスク管理機能", type: :system do
  describe "一覧表示" do
    let(:user_a) { FactoryBot.create(:user, name: "ユーザーA", email: "a@example.com") }
    let(:user_b) { FactoryBot.create(:user, name: "ユーザーB", email: "b@example.com") }
    # ↑letでuser_aとuser_bを定義
    before do
      FactoryBot.create(:task, name: "最初のタスク", user: user_a)
      # ユーザーAのタスクを作るところでuser_aを利用している。
      # ----共通化したいログイン処理----BEGIN
      visit login_path
      fill_in "メールアドレス", with: login_user.email
      fill_in "パスワード", with: login_user.password
      click_button "ログインする"
      # -------------END-----------------
    end

    context "ユーザーAがログインしている時" do
      let(:login_user) { user_a } # login_userを定義
      it "ユーザーAが作成したタスクが表示される" do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content "最初のタスク"
        # page(画面)に期待するよ、・・することを　　　#あるはずだよね、「最初のタスク」という内容が
      end
    end

    context "ユーザーBがログインしている時" do
      let(:login_user) { user_b } # login_userを定義

      it "ユーザーAが作成したタスクが表示されない" do
        # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認。
        expect(page).to have_no_content "最初のタスク"
      end
    end
  end
end
