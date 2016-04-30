$redis = Redis.new
$redis.set("cpu_threshold", Rails.application.secrets.cpu_threshold)
$redis.set("stopped_instances", [].to_json)