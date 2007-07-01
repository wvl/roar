class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :date, :datetime
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
      t.column :category_id, :integer
    end
  end

  def self.down
    drop_table :events
  end
end
