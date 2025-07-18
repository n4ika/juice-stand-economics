require "test_helper"

class JuicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get juices_index_url
    assert_response :success
  end

  test "should get show" do
    get juices_show_url
    assert_response :success
  end

  test "should get new" do
    get juices_new_url
    assert_response :success
  end

  test "should get create" do
    get juices_create_url
    assert_response :success
  end

  test "should get edit" do
    get juices_edit_url
    assert_response :success
  end

  test "should get update" do
    get juices_update_url
    assert_response :success
  end

  test "should get destroy" do
    get juices_destroy_url
    assert_response :success
  end

  test "should get sell" do
    get juices_sell_url
    assert_response :success
  end
end
