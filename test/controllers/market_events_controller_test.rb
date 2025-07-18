require "test_helper"

class MarketEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get market_events_index_url
    assert_response :success
  end
end
