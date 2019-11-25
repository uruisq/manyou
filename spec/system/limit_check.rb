require 'rails_helper'

RSpec.describe '終了期限のテスト', type: :system do

  before do
    @other_user = FactoryBot.create(:test01)
    visit login_path
    fill_in "メールアドレス", with: "test01@test.com"
    fill_in "パスワード", with: "555555"
    click_on "submit"
  end

  describe '終了期限のテスト' do
    context '複数件の登録のある一覧ページで' do
      before do
        Task.create!(id: '1',title: 'test1',limit: '2019/12/1 16:00',status: '未着手',user_id: @other_user.id)
        Task.create!(id: '2',title: 'test2',limit: '2019/12/2 16:00',status: '未着手',user_id: @other_user.id)
        Task.create!(id: '3',title: 'test3',limit: '2019/12/3 16:00',status: '未着手',user_id: @other_user.id)
        visit tasks_path
        click_on '詳細', match: :first
      end
      it '投稿が降順に並んでいるか確認' do
        expect(page).to have_content 'test3'
      end
    end

    context '複数件の登録のある一覧ページで終了期限の並び替えボタンを押すと' do
      before do
        Task.create!(id: '1',title: 'test1',limit: '2019/12/1 16:00',status: '未着手',user_id: @other_user.id)
        Task.create!(id: '2',title: 'test2',limit: '2019/12/2 16:00',status: '未着手',user_id: @other_user.id)
        Task.create!(id: '3',title: 'test3',limit: '2019/12/3 16:00',status: '未着手',user_id: @other_user.id)
        visit tasks_path
        click_on '期限'
        click_on '詳細', match: :first
      end
      it '投稿の並び替えが機能するか確認' do
        expect(page).to have_content 'test1'
      end
    end
  end
end