class MetricsController < ApplicationController
  def create
    validate_metric_params!
    threshold = $redis.get("threshold") || 100
    $redis.set("threshold", threshold)
    cpu_usage = metric_params[:cpu_usage]
    ec2_instance_id = metric_params[:ec2_instance_id]

    if ec2_instance_id != 'localhost' and cpu_usage > threshold
      $redis.set("threshold", cpu_usage)

      MetricsBroadcastJob.perform_later({action: "destroy"}.to_json)
      ShutdownJob.perform_later(ec2_instance_id)
    else

      ConfigBroadcastJob.perform_later({action: "threshold"}.to_json)
      MetricsBroadcastJob.perform_later metric_params.to_json
    end

    render nothing: true, status: 200
  end

  protected
  def metric_params
    params[:metric]
    #params.require(:metric).permit(:cpu_usage, :disk_usage, :ec2_instance_id, :auth_token, :running_processes => [])
  end
  def auth_token
    Rails.application.config.auth_token
  end
  def validate_metric_params!
    render nothing: true, status: 403 if metric_params[:auth_token] != auth_token
  end
end