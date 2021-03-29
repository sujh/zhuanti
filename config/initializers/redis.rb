require 'redis'

$redis = Redis.new(url: Rails.application.config_for(:settings)[:redis_uri])