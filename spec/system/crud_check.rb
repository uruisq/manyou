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
        click_button 'Create Task'
      end
      it '作成済みのタスクが表示される' do
        expect(page).to have_content 'manyou'
      end
    end

    context '任意のタスク詳細画面に遷移したら、' do
      before do
        visit new_task_path
        fill_in "title", with: 'kadai'
        click_button 'Create Task'
        visit tasks_path
        click_on 'Show'
      end
      it '該当タスクの内容が表示されたページに遷移する' do
        expect(page).to have_content 'kadai'
      end
    end
  end
end
