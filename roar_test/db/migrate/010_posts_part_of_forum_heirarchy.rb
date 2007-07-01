class PostsPartOfForumHeirarchy < ActiveRecord::Migration
  def self.up
    add_column "posts", "forum_id", :integer
    add_column "posts", "topic_id", :integer
    remove_column "posts", "title"
    remove_column "posts", "published"
  end

  def self.down
  end
end
