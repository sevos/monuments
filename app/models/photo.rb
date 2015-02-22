class Photo < ActiveRecord::Base
  belongs_to :monument
  delegate :collection, to: :monument
  mount_uploader :image, PhotoUploader

  scope :to_review, -> {
    where(approved: nil, published: true)
  }

  def image_uploader(controller)
    image.tap do |uploader|
      current_url = controller.request.url
      url = controller.create_collection_monument_photos_url(collection, monument, r: current_url)
      uploader.success_action_redirect = url
    end
  end

  def approve!
    update_attribute :approved, true
  end

  def reject!
    update_attribute :approved, false
  end
end
