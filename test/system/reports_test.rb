# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  LOGIN_PASSWORD = 'password'

  setup do
    @report = reports(:one)

    visit new_user_session_path
    fill_in 'Eメール', with: 'one@example.com'
    fill_in 'パスワード', with: LOGIN_PASSWORD
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

    fill_in '内容', with: '作成テストの内容'
    fill_in 'タイトル', with: '作成テストのタイトル'

    click_on '登録する'
    assert_text '日報が作成されました。'

    assert_text '作成テストのタイトル'
    assert_text '作成テストの内容'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in '内容', with: '内容変更後'
    fill_in 'タイトル', with: 'タイトル変更後'
    click_button '更新する'

    assert_text '日報が更新されました。', wait: 10

    assert_text 'タイトル変更後'
    assert_text '内容変更後'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'

    assert_no_text @report.title
    assert_no_text @report.content
  end
end
