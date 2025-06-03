require "test_helper"

class PharmacistControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pharmacist_index_url
    assert_response :success
  end

  test "should get show" do
    get pharmacist_show_url
    assert_response :success
  end
end
