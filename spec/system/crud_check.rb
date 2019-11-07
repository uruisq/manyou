require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  describe '一覧表示' do
    context 'タスク一覧画面に遷移したら、' do
      before do
        visit tasks_path
      end
      it '作成済みのタスクが表示される' do
        expect(page).to have_content 'Tasks'
      end
    end

    context 'タスク登録画面で、必要項目を入力してcreateボタンを押したら' do
      before do
        visit new_task_path
        fill_in "title", with: 'manyou'
        click_on '登録する'
      end
      it '作成済みのタスクが表示される' do
        expect(page).to have_content 'manyou'
      end
    end

    context '任意のタスク詳細画面に遷移したら、' do
      before do
        visit new_task_path
        fill_in "title", with: 'you'
        click_on '登録する'
        visit tasks_path
        click_on '詳細'
      end
      it '該当タスクの内容が表示されたページに遷移する' do
        expect(page).to have_content 'you'
      end
    end

    context '複数件の登録のある一覧ページで' do
      before do
        Task.create!(id: '1',title: 't1')
        Task.create!(id: '2',title: 't2')
        Task.create!(id: '3',title: 't3')
        visit tasks_path
        click_on '詳細', match: :first
      end
      it '投稿が降順に並んでいるか確認' do
        expect(page).to have_content 't3'
      end
    end

    context '複数件の登録のある一覧ページで' do
      before do
        Task.create!(id: '1',title: 't1')
        Task.create!(id: '2',title: 't2')
        Task.create!(id: '3',title: 't3')
        visit tasks_path
        click_on 'Created at'
        click_on '詳細', match: :first
      end
      it '投稿の並び替えが機能するか確認' do
        expect(page).to have_content 't1'
      end
    end
  end
end
