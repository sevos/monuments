class PhotosController < ApplicationController
  before_action :require_user, except: %i(index stream)
  before_action :require_own_monument, only: %i(create destroy)
  before_action :require_admin, only: %i(review approve reject)

  def index
    @photos = Photo.stream.order('id DESC')
  end

  def stream
    @photos = Photo.stream.order('id DESC')
  end

  def create
    photo = monument.photos.build(key: params[:key])
    photo.remote_image_url = photo.image.direct_fog_url(:with_path => true)
    if photo.save!
      redirect_to params[:r]
    else
      redirect_to collections_path
    end
  end

  def destroy
    @photo = monument.photos.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  def review
    @photo = Photo.to_review.first
  end

  def approve
    photo = Photo.find(params[:photo_id])
    photo.approve!
    redirect_to :back
  end

  def reject
    photo = Photo.find(params[:photo_id])
    photo.reject!
    redirect_to :back
  end

  private

  def monument
    @monument ||= collection.monuments.find(params[:monument_id])
  end

  def collection
    @collection ||= Collection.find(params[:collection_id])
  end

  def require_own_monument
    return true if monument.collection.user == current_user
    redirect_to collections_path
  end
end
