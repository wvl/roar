Roar is coming
--------------

```ruby
class PostsController < ApplicationController
  roar do  
    per_page 5
    order "published_at DESC, created_at"

    filters do
      search :text, [:title,:body]
      recent_dates :created_at
    end

    table do
      edit    :title
      column  :status
      date  :published_at
      delete
    end

    form do
      text_field :title
      text_area :body
      select_field :status, :choices=>Status.to_select
      check_box :published, :name=>"Published?"
    end
  end
end
```
