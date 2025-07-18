require "test_helper"

class EconomiesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get economies_show_url
    assert_response :success
  end

  test "should get reset" do
    get economies_reset_url
    assert_response :success
  end
end
