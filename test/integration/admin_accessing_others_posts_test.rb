require 'test_helper'

class AdminAccessingOthersPostsTest < ActionDispatch::IntegrationTest
  def user
    users(:alice)
  end

  def auth_headers
    http_login(user)
  end

  def blog_id
    2
  end

  def post_id
    2
  end

  test "Listing posts" do
    get "/posts", { format: "json" }, auth_headers
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal 2, data.length
  end

  test "Fetching a post" do
    get "/posts/#{post_id}", { format: "json" }, auth_headers
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal post_id, data["id"]
  end

  test "Creating a post" do
    assert_equal 2, Post.count

    post "/posts", { format: "json", post: { title: "New title", body: "blah", blog_id: blog_id } }, auth_headers
    assert_response :success

    assert_equal 3, Post.count
  end

  test "Updating a post" do
    patch "/posts/#{post_id}", { format: "json", post: { title: "New title" } }, auth_headers
    assert_response :success

    the_post = Post.find(post_id)
    assert_equal "New title", the_post.title

    data = JSON.parse(response.body)
    assert_equal "New title", data["title"]
  end

  test "Deletingg a post" do
    assert_equal 2, Post.count

    delete "/posts/#{post_id}", { format: "json" }, auth_headers
    assert_response :success

    assert_equal 1, Post.count
  end
end
