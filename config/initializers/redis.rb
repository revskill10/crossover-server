$redis = Redis.new
$redis.set("cpu_threshold", Rails.application.secrets.cpu_threshold)