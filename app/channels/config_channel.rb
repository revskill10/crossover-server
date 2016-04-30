# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConfigChannel < ApplicationCable::Channel
  def subscribed
    stream_from "config"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update(data)
    $redis.set("cpu_threshold", data.to_i)
    ConfigBroadcastJob.perform_later $redis.get("cpu_threshold")
  end
end
