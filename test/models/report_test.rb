# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '持ち主なら編集できる' do
    report = reports(:one)
    user = users(:one)

    assert report.editable?(user)
  end

  test '持ち主でなければ編集できない' do
    report = reports(:one)
    user = users(:two)

    assert_not report.editable?(user)
  end

  test '作成日を返す' do
    report = reports(:one)
    report.created_at = Time.zone.parse('2026-01-01 12:00:00')

    assert_equal Date.new(2026, 1, 1), report.created_on
  end

  test '日報本文に含まれる日報URLに応じてメンションを更新する' do
    mentioning_report = reports(:one)
    removed_report = reports(:two)
    kept_report = reports(:three)
    added_report = reports(:four)

    mentioning_report.content = [
      "http://localhost:3000/reports/#{removed_report.id}",
      "http://localhost:3000/reports/#{kept_report.id}"
    ].join("\n")
    mentioning_report.save!

    assert_includes mentioning_report.reload.mentioning_reports, removed_report
    assert_includes mentioning_report.mentioning_reports, kept_report

    mentioning_report.content = [
      "http://localhost:3000/reports/#{kept_report.id}",
      "http://localhost:3000/reports/#{added_report.id}"
    ].join("\n")
    mentioning_report.save!

    assert_not_includes mentioning_report.reload.mentioning_reports, removed_report
    assert_includes mentioning_report.mentioning_reports, kept_report
    assert_includes mentioning_report.mentioning_reports, added_report
  end
end
