class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.column :league_id, :integer
      t.column :division_id, :integer
      t.column :team1_id, :integer
      t.column :team2_id, :integer
      t.column :scheduled_at, :datetime
    end
  end

  def self.down
    drop_table :games
  end
end
