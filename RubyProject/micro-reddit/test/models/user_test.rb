require "test_helper"

class UserTest < ActiveSupport::TestCase
  def valid_user
    User.new(username: "testuser", email: "test@example.com")
  end

  test "valid user saves successfully" do
    assert valid_user.valid?
  end

  # username presence
  test "username is required" do
    user = valid_user
    user.username = ""
    assert_not user.valid?
    assert_includes user.errors[:username], "can't be blank"
  end

  # username length
  test "username must be at least 3 characters" do
    user = valid_user
    user.username = "ab"
    assert_not user.valid?
  end

  test "username at minimum length of 3 is valid" do
    user = valid_user
    user.username = "abc"
    assert user.valid?
  end

  test "username must be 20 characters or fewer" do
    user = valid_user
    user.username = "a" * 21
    assert_not user.valid?
  end

  test "username at maximum length of 20 is valid" do
    user = valid_user
    user.username = "a" * 20
    assert user.valid?
  end

  # username uniqueness
  test "username must be unique" do
    user = valid_user
    user.username = users(:alice).username
    assert_not user.valid?
    assert_includes user.errors[:username], "has already been taken"
  end

  test "username uniqueness is case-insensitive" do
    user = valid_user
    user.username = users(:alice).username.upcase
    assert_not user.valid?
  end

  # email presence
  test "email is required" do
    user = valid_user
    user.email = ""
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  # email format
  test "email must have valid format" do
    user = valid_user
    user.email = "not-an-email"
    assert_not user.valid?
  end

  test "email with valid format is accepted" do
    user = valid_user
    user.email = "user@domain.org"
    assert user.valid?
  end

  # email uniqueness
  test "email must be unique" do
    user = valid_user
    user.email = users(:alice).email
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  # email normalization
  test "email is stripped and downcased on save" do
    user = valid_user
    user.email = "  USER@Example.COM  "
    user.save!
    assert_equal "user@example.com", user.email
  end

  # post association
  test "user can have many posts" do
    assert_equal 1, users(:alice).posts.count
  end

  test "destroying a user destroys their posts" do
    user = users(:alice)
    post_id = user.posts.first.id
    user.destroy
    assert_not Post.exists?(post_id)
  end
end
