class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.column :title, :string
      t.column :forum_id, :integer
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :topics
  end
end
