# frozen_string_literal: true

module CommentsHelper
  def comment_user_name(comment)
    if comment.user
      comment.user.name.presence || comment.user.email
    else
      t('helpers.comments.withdrawn_user')
    end
  end
end
