# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader
  storage :fog
  enable_processing false
end
