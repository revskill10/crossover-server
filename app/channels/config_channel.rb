# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConfigChannel < ApplicationCable::Channel
  def subscribed
    stream_from "config"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update(data)
    threshold = data
    $redis.set("threshold", data)
    ConfigBroadcastJob.perform_later $redis.get("threshold")
  end
end
