require 'rails_helper'

RSpec.describe Task, type: :model do

  context '複数件の内容の異なる登録がある状態で' do
    before do
      Task.create!(id: '1',title: 'test1',status: '未着手')
      Task.create!(id: '2',title: 'test2',status: '着手中')
      Task.create!(id: '3',title: 'test3',status: '完了')
    end
        it "タイトル検索した場合、タイトルが含まれる検索結果を出す" do
            visit tasks_path
            fill_in "title_cont", with: '1'
            click_on '検索'
            expect(page).to have_content 'test1'
            expect(page).not_to have_content 'test3'
        end

        it "ステータス検索した場合、ステータスが含まれる検索結果を出す" do
            visit tasks_path
            fill_in "status_eq", with: '完了'
            click_on '検索'
            expect(page).to have_content 'test3'
            expect(page).not_to have_content 'test1'
        end
    end
end