class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.column :title, :string
      t.column :created_at, :date
      t.column :updated_at, :date
      t.column :body, :text
      t.column :published, :boolean
    end
  end

  def self.down
    drop_table :posts
  end
end
