class TeamsController < ApplicationController
  roar do
    filters do
      select_field :league_id, :choices => League.to_select, :prompt => "League: "
      scoped_select_field :division_id, :source => :division, :to => :league_id, :prompt => "Division: "
    end
    
    table do
      edit :name
      link(:"league.name", :name => "League") do edit_league_url(@record.league); end
      column :"division.name", :name => "Division"
    end
    
    form do
      select_field :league_id, :choices=>League.to_select, :prompt=>"League:"
      scoped_select_field :division_id, :source => :division, :to => :league_id, :prompt=>"Division:",
        :callback => lambda {|id| Division.to_select(id) }
      text_field :name
    end
  end
end