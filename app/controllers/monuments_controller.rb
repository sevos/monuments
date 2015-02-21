class MonumentsController < ApplicationController
  before_action :require_user
  before_action :require_own_collection

  def create
    monument = collection.monuments.create!()
    redirect_to [collection, monument, :monument_steps]
  end

  private

  def collection
    @collection ||= Collection.find(params[:collection_id])
  end

  def require_own_collection
    return true if collection.user == current_user
    flash[:error] = I18n.t('errors.own_collection')
    redirect_to collections_path
  end
end
