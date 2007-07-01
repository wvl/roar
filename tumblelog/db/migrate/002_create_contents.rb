class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :body_html, :text
      t.column :metadata, :text
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
      t.column :type, :string
    end
  end

  def self.down
    drop_table :contents
  end
end
