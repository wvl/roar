class CreateLeagues < ActiveRecord::Migration
  def self.up
    create_table :leagues do |t|
      t.column :name, :string
      t.column :year, :date
      t.column :season, :string
      t.column :active, :boolean
      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :leagues
  end
end
