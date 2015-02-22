CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV.fetch('AWS_ACCESS_KEY_ID'),
    :aws_secret_access_key  => ENV.fetch('AWS_SECRET_ACCESS_KEY'),       # required
    :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = ENV.fetch('AWS_FOG_DIRECTORY') # required
  # see https://github.com/jnicklas/carrierwave#using-amazon-s3
  # for more optional configuration
  config.enable_processing = false if Rails.env.test?
end
