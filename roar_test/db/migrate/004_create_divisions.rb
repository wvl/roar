class CreateDivisions < ActiveRecord::Migration
  def self.up
    create_table :divisions do |t|
      t.column :league_id, :integer
      t.column :name, :string
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :divisions
  end
end
