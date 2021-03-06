class MonumentStepsController < ApplicationController
  before_action :require_user
  before_action :require_own_monument

  include Wicked::Wizard

  steps :name_and_description, :photos, :confirmed

  def show
    initialize_variables
    render_wizard
  end

  def update
    initialize_variables
    params[:monument] = {} unless params[:monument].present?
    params[:monument][:state] = step.to_s
    monument.update_attributes(monument_params)
    render_wizard(monument)
  end

  private

  def initialize_variables
    @has_previous_step = previous_step != step
  end

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
             photos_attributes: [:id, :title, :description, :published])
  end

  def finish_wizard_path
    collections_path(anchor: "collection-#{collection.id}")
  end
end
