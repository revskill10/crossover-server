require 'test_helper'

class MetricsControllerTest < ActionDispatch::IntegrationTest
  test "should return success response" do
    metric_params = {
        auth_token: '123456',
        cpu_usage: '10%',
        disk_usage: '20',
        running_processes: [],
        ec2_instance_id: 'localhost'
    }
    post "/metrics", params: {metric: metric_params}
    assert_response :success
  end
  test "should call job" do

  end
end
