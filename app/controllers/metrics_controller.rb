class MetricsController < ApplicationController
  def create
    MetricsBroadcastJob.perform_later metric_params.to_json
    render nothing: true, status: 200
  end

  protected
  def metric_params
    params[:metric]
    #params.require(:metric).permit(:cpu_usage, :disk_usage, :ec2_instance_id, :auth_token, :running_processes => [])
  end
end