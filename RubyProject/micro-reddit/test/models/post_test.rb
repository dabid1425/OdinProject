require "test_helper"

class PostTest < ActiveSupport::TestCase
  def valid_post
    Post.new(
      user: users(:alice),
      title: "A Valid Title",
      body: "A valid body for this post."
    )
  end

  test "valid post saves successfully" do
    assert valid_post.valid?
  end

  # user association
  test "post requires a user" do
    post = valid_post
    post.user = nil
    assert_not post.valid?
    assert_includes post.errors[:user], "must exist"
  end

  # title presence
  test "title is required" do
    post = valid_post
    post.title = ""
    assert_not post.valid?
    assert_includes post.errors[:title], "can't be blank"
  end

  # title length
  test "title must be at least 2 characters" do
    post = valid_post
    post.title = "a"
    assert_not post.valid?
  end

  test "title at minimum length of 2 is valid" do
    post = valid_post
    post.title = "ab"
    assert post.valid?
  end

  test "title must be 100 characters or fewer" do
    post = valid_post
    post.title = "a" * 101
    assert_not post.valid?
  end

  test "title at maximum length of 100 is valid" do
    post = valid_post
    post.title = "a" * 100
    assert post.valid?
  end

  # body presence
  test "body is required" do
    post = valid_post
    post.body = ""
    assert_not post.valid?
    assert_includes post.errors[:body], "can't be blank"
  end

  # body length
  test "body must be at least 3 characters" do
    post = valid_post
    post.body = "ab"
    assert_not post.valid?
  end

  test "body at minimum length of 3 is valid" do
    post = valid_post
    post.body = "abc"
    assert post.valid?
  end

  test "body must be 500 characters or fewer" do
    post = valid_post
    post.body = "a" * 501
    assert_not post.valid?
  end

  test "body at maximum length of 500 is valid" do
    post = valid_post
    post.body = "a" * 500
    assert post.valid?
  end

  # association accessor
  test "post belongs to the correct user" do
    assert_equal users(:alice), posts(:first_post).user
  end

  test "post is accessible from its user" do
    assert_includes users(:alice).posts, posts(:first_post)
  end

  # persistence
  test "valid post can be saved to the database" do
    post = valid_post
    assert post.save
    assert post.persisted?
  end

  test "invalid post is not saved to the database" do
    post = valid_post
    post.title = ""
    assert_not post.save
    assert_not post.persisted?
  end
end
