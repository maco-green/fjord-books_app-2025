# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :correct_user, only: %i[destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = @commentable

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.expect(comment: [:body])
  end

  def set_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    elsif params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def correct_user
    @comment = Comment.find(params[:id])
    redirect_to @commentable, notice: t('controllers.comments.correct_user.notice') unless @comment.user == current_user
  end
end
