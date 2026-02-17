# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon

  validate :icon_content_type

  private

  def icon_content_type
    return unless icon.attached?
    return if icon.blob.content_type.in?(%w[image/jpeg image/png image/gif])

    errors.add(:icon, 'はJPEG/PNG/GIFのみアップロードできます')
  end
end
