class RemoveUrlFromPosts < ActiveRecord::Migration[8.1]
  def change
    remove_column :posts, :url, :string
  end
end
