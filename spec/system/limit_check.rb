require 'rails_helper'

RSpec.describe '終了期限のテスト', type: :system do

  describe '終了期限のテスト' do
    context '複数件の登録のある一覧ページで' do
      before do
        Task.create!(id: '1',title: 'test1',limit: '2019/12/1 16:00')
        Task.create!(id: '2',title: 'test2',limit: '2019/12/2 16:00')
        Task.create!(id: '3',title: 'test3',limit: '2019/12/3 16:00')
        visit tasks_path
        click_on '詳細', match: :first
      end
      it '投稿が降順に並んでいるか確認' do
        expect(page).to have_content 'test3'
      end
    end

    context '複数件の登録のある一覧ページで終了期限の並び替えボタンを押すと' do
      before do
        Task.create!(id: '1',title: 'test1',limit: '2019/12/1 16:00')
        Task.create!(id: '2',title: 'test2',limit: '2019/12/2 16:00')
        Task.create!(id: '3',title: 'test3',limit: '2019/12/3 16:00')
        visit tasks_path
        click_on 'Limit'
        click_on '詳細', match: :first
      end
      it '投稿の並び替えが機能するか確認' do
        expect(page).to have_content 'test1'
      end
    end
  end
end