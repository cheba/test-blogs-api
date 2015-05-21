require 'test_helper'

class AdminAccessingOthersBlogsTest < ActionDispatch::IntegrationTest
  def user
    users(:alice)
  end

  def auth_headers
    http_login user
  end

  def blog_id
    2
  end

  test "Listing blogs" do
    get "/blogs", { format: "json" }, auth_headers
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal 2, data.length
  end

  test "Fetching a blog" do
    get "/blogs/#{blog_id}", { format: "json" }, auth_headers
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal blog_id, data["id"]
  end

  test "Creating a blog" do
    assert_equal 1, user.blogs.count

    post "/blogs", { format: "json", blog: { title: "New title", user_id: user.id } }, auth_headers
    assert_response :success

    assert_equal 2, user.blogs.count
  end

  test "Updating a blog" do
    patch "/blogs/#{blog_id}", { format: "json", blog: { title: "New title" } }, auth_headers
    assert_response :success

    blog = Blog.find(blog_id)
    assert_equal "New title", blog.title

    data = JSON.parse(response.body)
    assert_equal "New title", data["title"]
  end

  test "Deletingg a blog" do
    assert_equal 1, Blog.where(id: blog_id).count

    delete "/blogs/#{blog_id}", { format: "json" }, auth_headers
    assert_response :success

    assert_equal 0, Blog.where(id: blog_id).count
  end
end
