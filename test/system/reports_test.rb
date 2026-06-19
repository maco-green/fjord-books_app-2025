# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)

    visit new_user_session_path
    fill_in 'Eメール', with: 'one@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。', wait: 10
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_link href: new_report_path

    fill_in '内容', with: @report.content
    fill_in 'タイトル', with: @report.title

    click_on '登録する'
    assert_text '日報が作成されました。'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in '内容', with: '内容変更後'
    fill_in 'タイトル', with: 'タイトル変更後'
    click_button '更新する'

    assert_text '日報が更新されました。', wait: 10
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
  end
end
