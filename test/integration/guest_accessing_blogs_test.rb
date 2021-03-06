require 'test_helper'

class GuestAccessingBlogsTest < ActionDispatch::IntegrationTest
  def user
    users(:alice)
  end

  def blog_id
    1
  end

  test "Listing blogs" do
    get "/blogs", { format: "json" }
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal 2, data.length
  end

  test "Fetching a blog" do
    get "/blogs/#{blog_id}", { format: "json" }
    assert_response :success

    data = JSON.parse(response.body)

    assert_equal blog_id, data["id"]
  end

  test "Creating a blog (not permitted)" do
    assert_equal 1, user.blogs.count

    post "/blogs", { format: "json", blog: { title: "New title", user_id: user.id } }
    assert_response 401

    assert_equal 1, user.blogs.count
  end

  test "Updating a blog (not permitted)" do
    patch "/blogs/#{blog_id}", { format: "json", blog: { title: "New title" } }
    assert_response 401

    blog = Blog.find(blog_id)
    assert_equal "Alice's Blog", blog.title

    data = JSON.parse(response.body)

    assert_equal false, data["error"].blank?
  end

  test "Deletingg a blog (not permitted)" do
    assert_equal 1, Blog.where(id: blog_id).count

    delete "/blogs/#{blog_id}", { format: "json" }
    assert_response 401

    assert_equal 1, Blog.where(id: blog_id).count
  end
end
