class ShutdownJob < ApplicationJob
  queue_as :default

  def perform(data)
    client = Aws::EC2::Client.new
    client.stop_instances({
      dry_run: false,
      instance_ids: ["String"], # required
      force: false,
    })
    ActionCable.server.broadcast 'metrics_channel', data: {action: "terminate", ec2_instance_id: data}
  end
end
