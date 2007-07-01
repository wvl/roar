class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      t.column :description, :text
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :polls
  end
end
