require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  test "Listing posts" do
    get "/posts", { format: "json" }, http_login(users(:alice))
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal 2, data.length
  end

  test "Fetching a post" do
    get "/posts/1", { format: "json" }, http_login(users(:alice))
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal 1, data["id"]
  end

  test "Creating a post" do
    alice = users(:alice)
    assert_equal 1, alice.posts.count

    post "/posts", { format: "json", post: { title: "New title", body: "blah", blog_id: 1 } }, http_login(alice)
    assert_response :success

    assert_equal 2, alice.posts.count
  end

  test "Updating a post" do
    patch "/posts/1", { format: "json", post: { title: "New title" } }, http_login(users(:alice))
    assert_response :success

    data = JSON.parse(response.body)

    the_post = Post.find(1)
    assert_equal "New title", the_post.title

    assert_equal "New title", data["title"]
  end

  test "Deletingg a post" do
    alice = users(:alice)
    assert_equal 1, alice.posts.count

    delete "/posts/1", { format: "json" }, http_login(alice)
    assert_response :success

    assert_equal 0, alice.posts.count
  end
end
