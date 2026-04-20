# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :mentioning_mentions, class_name: 'Mention', foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioned_mentions, class_name: 'Mention', foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :mentioned_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def find_report_ids
    content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i)
  end

  def update_mentions
    ActiveRecord::Base.transaction do
      find_report_ids.each do |report_id|
        Mention.create(mentioning_report_id: id, mentioned_report_id: report_id)
      end
    end
  end
end
