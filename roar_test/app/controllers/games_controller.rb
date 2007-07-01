class GamesController < ApplicationController
  roar do
    filters do
      select_field :league_id, :choices=>League.to_select, :prompt => "League:"
      scoped_select_field :division_id, :to => :league_id, :prompt => "Division: "
    end
    
    table do
      edit(:scheduled_at) { |date| date.to_s(:short) }
      column "league.name"
      column "division.name"
      column "team1.name"
      column "team2.name"
    end
    
    form do
      select_field :league_id, :choices=>League.to_select, :prompt=>"League:"
      scoped_select_field :division_id, :to => :league_id, :prompt=>"Division:", \
        :callback => lambda {|id| Division.to_select(id) }
      scoped_select_field :team1_id, :source => :team, :to => :division_id, :prompt => "Team 1:", \
        :callback => lambda { |division_id| Team.to_select(division_id) }
      scoped_select_field :team2_id, :source => :team, :to => :division_id, :prompt => "Team 2:", \
        :callback => lambda { |division_id| Team.to_select(division_id) }
      datetime_select :scheduled_at
    end
  end
end
