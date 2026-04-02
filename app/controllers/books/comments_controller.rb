# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  before_action :set_book
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.commentable = @book

    @comment.save!
    redirect_to @book, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @book, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @book, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.expect(comment: [:body])
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
