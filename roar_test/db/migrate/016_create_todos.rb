class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.column :description, :string
      t.column :done, :boolean
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :position, :integer
    end
  end

  def self.down
    drop_table :todos
  end
end
