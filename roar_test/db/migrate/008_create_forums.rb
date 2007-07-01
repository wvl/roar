class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
      t.column :position, :integer
    end
  end

  def self.down
    drop_table :forums
  end
end
