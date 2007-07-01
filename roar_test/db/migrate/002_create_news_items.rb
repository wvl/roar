class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :published_at, :datetime
    end
  end

  def self.down
    drop_table :news_items
  end
end
