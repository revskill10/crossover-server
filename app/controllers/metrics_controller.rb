class MetricsController < ApplicationController
  def create
    MetricsBroadcastJob.perform_later params[:metric].to_json
    render nothing: true, status: 200
  end
end