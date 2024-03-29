Roar 0.5, the Peter Gunn edition
--------------------------------

I was showing some of the cool new stuff in Roar to Bryan, and all he keeps saying is, _"You don't believe in release early, release often, do you?"_.  Guilty as charged -- but I've been cooking up some pretty sweet things in the meantime.  This release inspired by "Peter Gunn, _Hellecasters_":http://www.radioparadise.com/content.php?name=songinfo&song_id=2585   Here goes with a laundry list of some of the things that roar can now do that has me pretty excited: du du du du du du du du...

### How about door number 1, with dynamic repeating fields:

```ruby
# team.rb
class Team < ActiveRecord::Base
  has_many :players
  has_many :users, :through=>:players
end

# TeamsController:
form do
  text_field :name
  text_area :description
  select_field :league_id, :choices=>League.to_select
  has_many :players do
     auto_complete :user
     check_box :captain
     check_box :admin
  end
end
```

This produces repeating, nested forms on the collection, so you can edit the team and its players with one form.
The result:

<img width="500px" src="https://github.com/wvl/roar/raw/master/web/posts/img/repeating_fields.png" />

"Add Another" allows you to keep adding entries to the bottom of the form (via javascript).
 
### Or door number 2, with how do you want your roar?

```ruby
# routes.rb: The two lines are equivalent:
map.roar :users
map.resources :users, :path_prefix => "/admin", 
  :name_prefix => "roar_", :member => { :delete => :get }

# users_controller
roar :prefix => "admin" do
  table do
    edit :login
  end

  form do
    text_field :login
    # more fields
  end
end
```

Then you can access the admin backend at /admin/users.  Using the domain to control routing still works with <code>roar :subdomain => "admin" do</code>.  Pick whatever makes the most sense, or...

### Door number 3, have your cake and eat it too...

After going back into the public views, I started to miss the roar convenience.  I wanted to actually eat cake, so let there be cake!

```ruby
class PostsController < ApplicationController
  roar :prefix => "admin" do
    # Admin definition here
  end
		
  roar :view => "show" do
     # public view here
   end
end
```

### It's a big hallway: Table actions

Define actions that happen to data as a collection:

```ruby
table(:name => "table") do
  action
  edit :description
  boolean :done
  actions do
    done
    undone :name=>"Not Done"
    delete_checked :confirm=>"Delete all checked todos?"
  end
end
```

Creates:

<img src="https://github.com/wvl/roar/raw/master/web/posts/img/todolist.png" />

### Multiple data views

The above screenshot actually shows an alternate data view (data as a list).  Multiple views can be defined side by side, and switched between with the view url parameter.

```ruby
table(:view => "list") do
  action
  edit :description
  boolean :done
  actions { sortable;   done;   undone :name => "Not Done";
    delete_checked :confirm=>"Delete all checked todos?"
  }
end
```


### Sortable

The list view can take a sortable action, for data that <code>acts_as_list</code>.

### Separate new/edit forms:

```ruby
new_form do
  text_field :username
  text_field :password
end

edit_form do
  text_field :firstname
  text_field :lastname
  text_area :bio
end
```


Where to from here?

Roar is still in a constant state of flux, so there will be api changes, but the more feedback, the faster it'll stabilize.  
Check it out at: "http://nanoware.com/roar":http://nanoware.com/roar
