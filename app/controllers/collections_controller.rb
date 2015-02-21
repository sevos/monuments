class CollectionsController < ApplicationController
  before_action :require_user

  def index
    @collections = collections.order('id DESC')
  end

  def create
    @collection = collections.build(collection_params)
    @success = @collection.save
  end

  def destroy
    @collection = collections.where(id: params[:id]).first!
    @collection.destroy
  end

  private

  def collections
    Collection.where(user: current_user)
  end

  def collection_params
    params.require(:collection).permit(:title)
  end
end
