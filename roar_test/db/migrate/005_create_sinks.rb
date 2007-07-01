class CreateSinks < ActiveRecord::Migration
  def self.up
    create_table :sinks do |t|
      t.column :name, :string
      t.column :body, :text
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
      t.column :washed_at, :datetime
      t.column :purchased_on, :date
      t.column :status, :string
      t.column :attachment, :string
      t.column :shiny, :boolean
      t.column :protected_by, :string
      t.column :style, :string
    end
  end

  def self.down
    drop_table :sinks
  end
end
