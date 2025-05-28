require "test_helper"

class PharmacyControllerTest < ActionDispatch::IntegrationTest
  test "should get menu" do
    get pharmacy_menu_url
    assert_response :success
  end

  test "should get item" do
    get pharmacy_item_url
    assert_response :success
  end

  test "should get discount" do
    get pharmacy_discount_url
    assert_response :success
  end

  test "should get search" do
    get pharmacy_search_url
    assert_response :success
  end

  test "should get my_profile" do
    get pharmacy_my_profile_url
    assert_response :success
  end
end
