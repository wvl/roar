class Game < ActiveRecord::Base
  belongs_to :league
  belongs_to :division
  belongs_to :team1, :class_name=>"Team", :foreign_key=>"team1_id"
  belongs_to :team2, :class_name=>"Team", :foreign_key=>"team2_id"
end
