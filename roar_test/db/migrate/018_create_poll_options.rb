class CreatePollOptions < ActiveRecord::Migration
  def self.up
    create_table :poll_options do |t|
      t.column :option, :string
      t.column :poll_id, :integer
    end
  end

  def self.down
    drop_table :poll_options
  end
end
