Roar screenshots
----------------

### News List

<img src="https://github.com/wvl/roar/raw/master/web/posts/img/news_list.png" />

```ruby
class NewsController < ApplicationController
  roar :subdomain => "admin" do
    order "posted_at DESC"
    
    filters do
      search :text, [:title, :intro, :body]
      select_field :status, :choices => News.status_options, :prompt=>"Status:"
      recent_dates :posted_at
    end
    
    table do
      edit    :title
      date    :posted_at, :format=>:short
      inline_select :status, :choices => News.status_options
      column  :author
      delete
    end
    
    form do
      text_field    :title
      text_area     :intro
      text_area     :body
      select_field :news_category_id, :choices => NewsCategory.to_select, :prompt=>true
      select_field :status, :choices => News.status_options, :prompt=>true
    end
  end
```

### Edit Event

<img src="https://github.com/wvl/roar/raw/master/web/posts/img/edit_event.png" />

```ruby
class EventsController < ApplicationController
  roar :subdomain=>"admin" do
    order "date DESC"
    per_page 10
    
    filters do
      search :text, [:name,:location,:description]
      recent_dates :date
    end
    
    table do
      edit :name
      date :date
      column :location
      delete
    end
    
    form do
      text_field :name
      text_field :location
      datetime_select :date
      text_area :description
    end
  end
end
```

### Leagues and Divisions

This shot illustrates nested resources, with inline editing -- Divisions are nested within Leagues.

<img src="https://github.com/wvl/roar/raw/master/web/posts/img/leagues.png" />

```ruby
class LeaguesController < ApplicationController
  roar :subdomain=>"admin" do
    order "year DESC"
    include "divisions"
    
    table do
      edit :name
      column :year
      column :season
      has_many :divisions, :inline=>true
      delete
    end
    
    form do
      text_field :name
      select_field :season, :choices => League.season_options, :prompt => true
    end
  end
end

class DivisionsController < ApplicationController
  roar :subdomain=>"admin", :parent=>:league do
    table do
      edit :name
      has_many :games
      has_many :teams
      delete
    end
    
    form do
      text_field :name
    end
  end  
end
```

### New Game 

This shot illustrates the scoped select field in action.  Divisions are scoped to a League, and Teams are scoped to the Division.

This shot also illustrates the custom actions in place (:save_and_add_another).

<img src="https://github.com/wvl/roar/raw/master/web/posts/img/new_game.png" />

```ruby
class GamesController < ApplicationController
  roar :subdomain => "admin" do
    order "scheduled_at DESC"
    include [:division, :league, :team1, :team2]

    filters do
      select_field "league_id", :choices=>League.to_select, :prompt=>"League:"
      scoped_select_field "division_id", :to=>:league_id, :prompt=> "Division:"
    end
    
    table do
      edit(:scheduled_at) { |date| date.to_s(:short) }
      column(:division) { |div| "#{div.league.name}, #{div.name}" }
      column "team1.name"
      column "team2.name"
      column "score1"
      column "score2"
      column :played
      delete
    end
    
    form do
      select_field :league_id, :choices => League.to_select, :prompt => "League: "
      scoped_select_field :division_id, :to => :league_id, :prompt => "Division: " do |league_id|
        League.find(league_id).divisions.map { |div| [div.name, div.id] }
      end
      scoped_select_field :team1_id, :source => :team, :to => :division_id, :prompt => "Team 1:" do |div_id|
        Division.find(div_id).teams.map { |team| [team.name, team.id] }
      end
      scoped_select_field :team2_id, :source => :team, :to => :division_id, :prompt => "Team 2:" do |div_id|
        Division.find(div_id).teams.map { |team| [team.name, team.id] }
      end
      datetime_select :scheduled_at
      text_field :duration
      actions [:save, :save_and_add_another, :delete]
    end
  end
end
```
