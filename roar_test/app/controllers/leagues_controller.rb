class LeaguesController < ApplicationController
  roar do  
    per_page 5
    order "year DESC, leagues.name"
    include "divisions"

    filters do
      search :text, :fields => [:name,:season]
      recent_dates :created_at
      select_field :season, :choices=>[["Summer", "summer"], ["Winter", "winter"]], :prompt=>"by season..."
    end

    table do
      edit :name
      column :year
      inline_select :season, :choices=>[["Summer", "summer"], ["Winter", "winter"]]
      column :active
      has_many :divisions, :inline=>true
      delete
    end

    form do
      text_field :name
      date_select :year, {:discard_month=>true, :discard_day=>true}
      select_field :season, :choices=>[["Summer", "summer"], ["Winter", "winter"]]
      check_box :active
    end
  end
end
