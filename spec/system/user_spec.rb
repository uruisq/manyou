require 'rails_helper'

RSpec.describe "ユーザのsystem spec", type: :system do

  before do
    @test01 = FactoryBot.create(:test01)
    @test02 = FactoryBot.create(:test02)
    @test03 = FactoryBot.create(:test03)
    Task.create!(id: '1',title: 'test01',status: '未着手',user_id: @test01.id)
    Task.create!(id: '2',title: 'test02',status: '未着手',user_id: @test02.id)
    Task.create!(id: '3',title: 'test03',status: '未着手',user_id: @test03.id)
  end

  context 'ユーザー機能' do
    it "ログインログアウト機能（同時にログイン）" do
      visit login_path
      fill_in "メールアドレス", with: "test01@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit user_path(@test01.id)
      expect(page).to have_content 'test01@test.com'
      click_on "ログアウト"
      expect(page).not_to have_content 'test01@test.com'
    end
  end
  context 'ユーザー画面のコントロール' do
    it "ログインしている時は、ユーザー登録画面に行かせない" do
      visit login_path
      fill_in "メールアドレス", with: "test01@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit new_user_path
      expect(page).not_to have_content 'サインイン'
    end
    it "自分以外のユーザのマイページに行かせない" do
      visit login_path
      fill_in "メールアドレス", with: "test01@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit user_path(@test02.id)
      expect(page).not_to have_content 'test02@test.com'
    end
    it "ログインしていないのにタスクのページに飛ぼうとした場合は、ログインページに遷移" do
      visit tasks_path
      expect(page).to have_content 'ログイン画面'
    end
    it "タスクの表示は自分が作成したタスクだけを表示" do
      visit login_path
      fill_in "メールアドレス", with: "test01@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit tasks_path
      expect(page).not_to have_content 'test02'
    end
  end
  context '管理者機能' do
    it "一般ユーザーはユーザ管理画面にアクセスできない" do
      visit login_path
      fill_in "メールアドレス", with: "test01@test.com"
      fill_in "パスワード", with: "555555"
      click_on "submit"
      visit admin_users_path
      expect(page).not_to have_content 'test02@test.com'
    end
    it "管理ユーザだけがユーザ管理画面にアクセスできる" do
      visit login_path
      fill_in "メールアドレス", with: "test03@test.com"
      fill_in "パスワード", with: "111111"
      click_on "submit"
      visit admin_users_path
      expect(page).to have_content 'test02@test.com'
    end
    it "管理画面でユーザ一の作成・編集・削除ができる（権限の付与ができる）" do
      visit login_path
      fill_in "メールアドレス", with: "test03@test.com"
      fill_in "パスワード", with: "111111"
      click_on "submit"
      visit admin_users_path
      click_on "新規ユーザー登録"
      fill_in "name", with: "test04"
      fill_in "email", with: "test04@test.com"
      fill_in "password", with: "111111"
      fill_in "password_confirmation", with: "111111"
      check "管理者権限"
      click_on "新規登録"
      visit admin_users_path
      expect(page).to have_content "test04@test.com"
      click_on "編集", match: :first
      fill_in "name", with: "test01a"
      fill_in "email", with: "test01a@test.com"
      fill_in "password", with: "555555"
      fill_in "password_confirmation", with: "555555"
      check "管理者権限"
      click_on "ユーザーを更新"
      visit admin_users_path
      expect(page).to have_content "test01a@test.com"
      visit admin_users_path
      click_on "削除", match: :first
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content "test02"
    end
  end
end