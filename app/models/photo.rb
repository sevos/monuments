class Photo < ActiveRecord::Base
  belongs_to :monument
  mount_uploader :image, PhotoUploader
end
