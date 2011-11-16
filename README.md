** Note: This is an old project, no longer maintained or operable. **

This is an archive of an old project of mine. *roar*, or *"roar offers
automated rails"* was a rails plugin that adds automated admin
functionality. It provided a custom DSL to describe how the admin
functionality for each resource.

I think it had some interesting ideas such as defining and overriding
form field, filters, and columns by simply adding an erb file in a
certain directory. Also, Overriding and theming was done by
manipulating the view path. Plus it was a great learning experience,
and taught me a lot about metaprogramming.

Example:

```rb
  class PostsController < ApplicationController
    roar do
      per_page 5
      order "published_at DESC, created_at"

      filters do
        search :text, fields => [:title,:body]
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

More docs are in the web/posts directory.
