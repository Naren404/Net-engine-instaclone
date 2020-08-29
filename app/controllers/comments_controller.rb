# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    @photo = Photo.find(params[:photo_id])
    comment = @photo.comments.build comment_params

    flash[:alert] = comment.errors.full_messages.join(' ') unless comment.save
    redirect_to photo_path(@photo)
  end

  def edit
    @photo = comment&.photo

    render 'photos/show'
  end

  def update
    comment&.update comment_params
    redirect_to photo_path(comment.photo)
  end

  def destroy
    comment&.destroy
    redirect_to photo_path(comment.photo)
  end

  private

  def comment
    @comment ||= current_user.comments.find(params[:id])
  end

  def comment_params
    params.permit(:content).merge(user_id: current_user.id)
  end
end
