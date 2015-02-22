class PhotosController < ApplicationController
  before_action :require_user
  before_action :require_own_monument

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
