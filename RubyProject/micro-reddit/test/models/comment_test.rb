require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def valid_comment
    Comment.new(
      user: users(:alice),
      post: posts(:first_post),
      body: "A valid comment body."
    )
  end

  test "valid comment saves successfully" do
    assert valid_comment.valid?
  end

  test "valid reply saves successfully" do
    reply = valid_comment
    reply.parent = comments(:top_comment)
    assert reply.valid?
  end

  # user association
  test "comment requires a user" do
    comment = valid_comment
    comment.user = nil
    assert_not comment.valid?
    assert_includes comment.errors[:user], "must exist"
  end

  # post association
  test "comment requires a post" do
    comment = valid_comment
    comment.post = nil
    assert_not comment.valid?
    assert_includes comment.errors[:post], "must exist"
  end

  # body presence
  test "body is required" do
    comment = valid_comment
    comment.body = ""
    assert_not comment.valid?
    assert_includes comment.errors[:body], "can't be blank"
  end

  # body length
  test "body must be at least 3 characters" do
    comment = valid_comment
    comment.body = "ab"
    assert_not comment.valid?
  end

  test "body at minimum length of 3 is valid" do
    comment = valid_comment
    comment.body = "abc"
    assert comment.valid?
  end

  test "body must be 500 characters or fewer" do
    comment = valid_comment
    comment.body = "a" * 501
    assert_not comment.valid?
  end

  test "body at maximum length of 500 is valid" do
    comment = valid_comment
    comment.body = "a" * 500
    assert comment.valid?
  end

  # parent validation
  test "parent must be on the same post" do
    comment = valid_comment
    comment.parent = comments(:top_comment)
    comment.post = posts(:second_post)
    assert_not comment.valid?
    assert_includes comment.errors[:parent], "must be on the same post"
  end

  test "parent on the same post is valid" do
    comment = valid_comment
    comment.parent = comments(:top_comment)
    assert comment.valid?
  end

  # association accessors
  test "comment belongs to correct user" do
    assert_equal users(:alice), comments(:top_comment).user
  end

  test "comment belongs to correct post" do
    assert_equal posts(:first_post), comments(:top_comment).post
  end

  test "reply belongs to correct parent" do
    assert_equal comments(:top_comment), comments(:reply_comment).parent
  end

  test "top-level comment has no parent" do
    assert_nil comments(:top_comment).parent
  end

  # replies association
  test "comment can have replies" do
    assert_includes comments(:top_comment).replies, comments(:reply_comment)
  end

  test "destroying a comment destroys its replies" do
    parent = comments(:top_comment)
    reply_id = comments(:reply_comment).id
    parent.destroy
    assert_not Comment.exists?(reply_id)
  end
end
