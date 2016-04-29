class MetricsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    # Do something later
    ActionCable.server.broadcast 'metrics_channel', data: JSON.parse(data)
  end
end
