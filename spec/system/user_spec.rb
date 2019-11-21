require 'rails_helper'

RSpec.describe "ユーザのsystem spec", type: :system do

  before do
    @other_user = FactoryBot.create(:test01)
    @another_user = FactoryBot.create(:test02)
    Task.create!(id: '1',title: 'test1',status: '未着手',user_id: @other_user.id)
    Task.create!(id: '2',title: 'test2',status: '未着手',user_id: @other_user.id)
    Task.create!(id: '3',title: 'test3',status: '未着手',user_id: @other_user.id)
    Task.create!(id: '4',title: 'test4',status: '未着手',user_id: @another_user.id)
    Task.create!(id: '5',title: 'test5',status: '未着手',user_id: @another_user.id)
    Task.create!(id: '6',title: 'test6',status: '未着手',user_id: @another_user.id)
  end

  context 'ユーザー機能' do
    it "ログインログアウト機能（同時にログイン）" do
      visit login_path
      fill_in "メールアドレス", with: "test02@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit user_path(@another_user.id)
      expect(page).to have_content 'test02@test.com'
      click_on "ログアウト"
      expect(page).not_to have_content 'test02@test.com'
    end
  end
  context 'ユーザー画面のコントロール' do
    it "ログインしている時は、ユーザー登録画面に行かせない" do
      visit login_path
      fill_in "メールアドレス", with: "test02@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit new_user_path
      expect(page).not_to have_content 'サインイン'
    end
    it "自分以外のユーザのマイページに行かせない" do
      visit login_path
      fill_in "メールアドレス", with: "test02@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit user_path(@other_user.id)
      expect(page).not_to have_content 'test01@test.com'
    end
    it "ログインしていないのにタスクのページに飛ぼうとした場合は、ログインページに遷移" do
      visit tasks_path
      expect(page).to have_content 'ログイン画面'
    end
    it "タスクの表示は自分が作成したタスクだけを表示" do
      visit login_path
      fill_in "メールアドレス", with: "test02@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit tasks_path
      expect(page).not_to have_content 'test1'
    end
  end
  context '管理者機能' do
    it "一般ユーザーはユーザ管理画面にアクセスできない" do
      visit login_path
      fill_in "メールアドレス", with: "test02@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit admin_users_path
      expect(page).not_to have_content 'test01'
    end
    it "管理ユーザだけがユーザ管理画面にアクセスできる" do
      visit login_path
      fill_in "メールアドレス", with: "test01@test.com"
      fill_in "パスワード", with: "111111"
      click_on "submit"
      visit admin_users_path
      expect(page).to have_content 'test02'
    end
    it "管理画面でユーザ一覧・作成・更新・削除ができる" do
      visit login_path
      fill_in "メールアドレス", with: "test01@test.com"
      fill_in "パスワード", with: "111111"
      click_on "submit"
      visit admin_users_path
      expect(page).to have_content "新規ユーザー登録"
      expect(page).to have_content "編集"
      expect(page).to have_content "削除"
    end
  end
end