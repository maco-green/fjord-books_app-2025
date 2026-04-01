# frozen_string_literal: true

module CommentsHelper
  def comment_user_name(comment)
    comment.user&.name.presence || comment.user&.email || t('helpers.comments.withdrawn_user')
  end
end
