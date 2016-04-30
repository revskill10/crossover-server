require 'test_helper'

class MetricsControllerTest < ActionDispatch::IntegrationTest
  def setup
    assert_equal $redis.get("cpu_threshold").to_i, 50
    @metric_params = {
        auth_token: '123456',
        cpu_usage: '10%',
        disk_usage: '20',
        running_processes: ['a', 'b'],
        ec2_instance_id: 'localhost'
    }
  end
  test "should return success response" do

    post "/metrics", params: {metric: @metric_params}
    assert_response :success
  end
  test "should return 403 unless auth_token is provided" do
    metric_params = {
        auth_token: '12345'
    }
    post "/metrics", params: {metric: metric_params}
    assert_response(403)
  end
  test "should return 400 without parameters" do
    metric_params = {
        auth_token: '123456',
        cpu_usage: '10'
    }
    post "/metrics", params: {metric: metric_params}
    assert_response(400)
  end
  test "should set threshold" do
    @metric_params[:cpu_usage] = "60"
    @metric_params[:ec2_instance_id] = "test_instance"
    post "/metrics", params: {metric: @metric_params}
    assert_not_nil $redis.get("stopped_instances")
    stopped_instances = JSON.parse($redis.get("stopped_instances"))
    assert_equal stopped_instances, ["test_instance"]
  end
end
