require 'test_helper'

class BlogsTest < ActionDispatch::IntegrationTest
  test "Listing blogs" do
    get "/blogs", { format: "json" }, http_login(users(:alice))
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal 2, data.length
  end

  test "Fetching a blog" do
    get "/blogs/1", { format: "json" }, http_login(users(:alice))
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal 1, data["id"]
  end

  test "Creating a blog" do
    alice = users(:alice)
    assert_equal 1, alice.blogs.count

    post "/blogs", { format: "json", blog: { title: "New title", user_id: 1 } }, http_login(alice)
    assert_response :success

    assert_equal 2, alice.blogs.count
  end

  test "Updating a blog" do
    patch "/blogs/1", { format: "json", blog: { title: "New title" } }, http_login(users(:alice))
    assert_response :success

    data = JSON.parse(response.body)

    blog = Blog.find(1)
    assert_equal "New title", blog.title

    assert_equal "New title", data["title"]
  end

  test "Deletingg a blog" do
    alice = users(:alice)
    assert_equal 1, alice.blogs.count

    delete "/blogs/1", { format: "json" }, http_login(alice)
    assert_response :success

    assert_equal 0, alice.blogs.count
  end
end
