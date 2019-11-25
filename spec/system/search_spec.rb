require 'rails_helper'

RSpec.describe "検索能力", type: :system do

  before do
    @other_user = FactoryBot.create(:test01)
    visit login_path
    fill_in "メールアドレス", with: "test01@test.com"
    fill_in "パスワード", with: "555555"
    click_on "submit"
  end

  context '複数件の内容の異なる登録がある状態で' do
    before do
      Task.create!(id: '1',title: 'test1',status: '未着手',user_id: @other_user.id)
      Task.create!(id: '2',title: 'test2',status: '着手中',user_id: @other_user.id)
      Task.create!(id: '3',title: 'test3',status: '完了',user_id: @other_user.id)
    end
        it "タイトル検索した場合、タイトルが含まれる検索結果を出す" do
            visit tasks_path
            fill_in "s_title", with: '1'
            click_on '検索'
            expect(page).to have_content 'test1'
            expect(page).not_to have_content 'test3'
        end
        it "ステータス検索した場合、ステータスが含まれる検索結果を出す" do
          visit tasks_path
          select '完了'
          click_on '検索'
          expect(page).to have_content 'test3'
          expect(page).not_to have_content 'test1'
      end
    end
end