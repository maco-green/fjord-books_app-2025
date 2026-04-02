# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_report
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.commentable = @report

    @comment.save!
    redirect_to @report, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @report, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.expect(comment: [:body])
  end

  def set_report
    @report = Report.find(params[:report_id])
  end
end
