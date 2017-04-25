require 'test_helper'

class SubPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get sub:integer" do
    get sub_posts_sub:integer_url
    assert_response :success
  end

  test "should get author:integer" do
    get sub_posts_author:integer_url
    assert_response :success
  end

end
