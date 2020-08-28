# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :authenticate_user!, only: %i[new create delete]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @photos = Photo.all.order(created_at: :desc)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build photo_params

    if @photo.save
      redirect_to photo_path @photo
    else
      render :new
    end
  end

  def destroy
    @photo = current_user.photos.find(params[:id])

    @photo.destroy
    redirect_to root_path
  end

  private

  def photo_params
    params.require(:photo).permit(:photo, :description)
  end
end
