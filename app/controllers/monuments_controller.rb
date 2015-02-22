class MonumentsController < ApplicationController
  before_action :require_user
  before_action :require_own_collection

  def create
    monument = collection.monuments.create!()
    redirect_to [collection, monument, :monument_steps]
  end

  def edit
  end

  def update
    if monument.update_attributes(monument_params)
      redirect_to collections_path(anchor: "collection-#{collection.id}")
    else
      render 'edit'
    end
  end

  private

  def monument
    @monument = collection.monuments.find(params[:id])
  end
  helper_method :monument

  def collection
    @collection ||= Collection.find(params[:collection_id])
  end

  def require_own_collection
    return true if collection.user == current_user
    flash[:error] = I18n.t('errors.own_collection')
    redirect_to collections_path
  end

  def monument_params
    params.require(:monument).permit(:name, :description,
                                     photos_attributes: [:id, :title,
                                                         :published,
                                                         :description])
  end
end
