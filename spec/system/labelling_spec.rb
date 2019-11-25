require 'rails_helper'

RSpec.describe "エラーページとラベリング機能のsystem spec", type: :system do

  before do
    @test03 = FactoryBot.create(:test03)
    FactoryBot.create(:tag01)
    FactoryBot.create(:tag02)
    Task.create!(id: '1',title: 'test01',limit: '2019/12/1 16:00',status: '未着手',user_id: @test03.id)
    visit login_path
    fill_in "メールアドレス", with: "test03@test.com"
    fill_in "パスワード", with: "111111"
    click_on "submit"
  end

  context 'ラベリング機能' do
    it "編集画面で、タスクにラベルが複数付けられ、詳細画面で確認できる" do
      visit tasks_path
      click_on '編集', match: :first
      check ('tag01')
      check ('tag02')
      click_button '更新する'
      expect(page).to have_content 'tag01'
      expect(page).to have_content 'tag02'
    end
  end

  context 'エラーページ機能' do
    it "404エラーページに遷移し、ステータスコードが404であること" do
      visit '/tasks/404test'
      expect(page).to have_content '404'
    end
    it "500エラーページに遷移し、ステータスコードが500であること" do
      allow_any_instance_of(TasksController).to receive(:index).and_throw(Exception)
      visit tasks_path
      expect(page).to have_content '500'
    end
  end
end