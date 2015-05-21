require 'test_helper'

class GuestAccessingPostsTest < ActionDispatch::IntegrationTest
  def blog_id
    1
  end

  def post_id
    1
  end

  test "Listing posts" do
    get "/posts", { format: "json" }
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal 2, data.length
  end

  test "Fetching a post" do
    get "/posts/#{post_id}", { format: "json" }
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal post_id, data["id"]
  end

  test "Creating a post (not permitted)" do
    assert_equal 2, Post.count

    post "/posts", { format: "json", post: { title: "New title", body: "blah", blog_id: blog_id } }
    assert_response 401

    assert_equal 2, Post.count
  end

  test "Updating a post (not permitted)" do
    patch "/posts/#{post_id}", { format: "json", post: { title: "New title" } }
    assert_response 401

    the_post = Post.find(post_id)
    assert_equal "Alice's first post", the_post.title

    data = JSON.parse(response.body)
    assert_equal false, data["error"].blank?
  end

  test "Deletingg a post" do
    assert_equal 2, Post.count

    delete "/posts/#{post_id}", { format: "json" }
    assert_response 401

    assert_equal 2, Post.count
  end
end
