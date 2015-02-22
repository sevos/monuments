class MonumentStepsController < ApplicationController
  before_action :require_user
  before_action :require_own_monument

  include Wicked::Wizard

  steps :name_and_description, :photos, :confirmed

  def show
    @has_previous_step = previous_step != step
    @photo = Photo.new
    @photo_uploader = @photo.image
    @photo_uploader.success_action_redirect = create_collection_monument_photos_url(collection, monument, r: request.url)
    render_wizard
  end

  def update
    params[:monument] = {} unless params[:monument].present?
    params[:monument][:state] = step.to_s
    monument.update_attributes(monument_params)
    render_wizard(monument)
  end

  private

  def monument
    @monument ||= collection.monuments.find(params[:monument_id])
  end
  helper_method :monument

  def collection
    @collection ||= Collection.find(params[:collection_id])
  end

  def require_own_monument
    return true if monument.collection.user == current_user
    redirect_to collections_path
  end

  def monument_params
    params.require(:monument).
      permit(:name, :description, :state,
             photos_attributes: [:id, :title, :name, :_destroy])
  end

  def finish_wizard_path
    collections_path(anchor: "collection-#{collection.id}")
  end
end
