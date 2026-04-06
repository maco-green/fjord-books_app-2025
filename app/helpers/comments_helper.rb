# frozen_string_literal: true

module CommentsHelper
  def display_user_name(user)
    if user
      user.name.presence || user.email
    else
      t('helpers.comments.withdrawn_user')
    end
  end
end
