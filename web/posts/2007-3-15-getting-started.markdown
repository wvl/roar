Getting Started
---------------

Installation
------------

**Plugin**:

```
$ ./script/plugin install svn://rubyforge.org/var/svn/roar/trunk/roar
```

**Dependencies**:

The plugin is currently dependent on [criteriaquery](http://www.muermann.org/ruby/criteria_query/ "Criteria Query"), which is used for building the filter queries, and the [paginator](http://paginator.rubyforge.org/ "Paginator Gem")

```
$ ./script/plugin install svn://rubyforge.org/var/svn/criteriaquery
$ sudo gem install paginator
```

**Install the assets**:

```
$ rake roar:install
```
    
This copies the images, stylesheets, javascripts and layouts required for the plugin.  Note, that everything is installed into a `roar` subdirectory, in order to prevent pollution of your application's namespace.

Writing your first interface
----------------------------

Let's take an example controller:

```ruby
class PostController < ApplicationController
  roar :subdomain => "admin" do
    order "published_at DESC"

    table do
      edit :title
      column :author_name
      date :published_at
      delete
    end

    form do
      text_field :title
      text_area :body, :name=>"Post Body"
      check_box :published
    end

    filters do
      search :text, [:title, :body]
      recent_dates :created_at
    end
  end

  def index
    ...
  end
end
```

Taking this line by line, we will examine what is happening here:

```ruby
class PostController < ApplicationController
```

Roar tries to work with your application, and not operate in a separate world.  Roar mixes in the controller methods for operation, and does not require that you inherit from a special controller.  Thus, you create your resources and controllers as you would for any resource based app for Rails 1.2.  The roar interface lives in the controller, so regular rails techniques apply.  As an example, authentication is not handled by Roar, but can be handled by a regular `before_filter`.  

```ruby
roar :subdomain => "admin" do
```

Tell the controller to provide the Roar interface.  This will mixin the actions for a restful controller. By passing in the :subdomain option, Roar will only respoond if you are accessing the application with a subdomain of admin.  This lets you use this controller for both the admin backend and the public facing views, switching between the two through the domain name.  By default roar provides a custom layout 

```ruby
order "created_at DESC"
```

`order`, `include`, and `per_page` are passed through to the find query.  In this case, sort the results based on creation date in descending order.

```ruby
table do
```

The table block describes the main list interface for the index action.  Rather than try to discern the appropriate attributes to display through introspection, Roar takes the philosophy that any application will require some level of user intervention to get a reasonable data display.  By the time all includes, excludes and ordering are done, it is simpler and certainly more understandable to simply describe the interface in full.

```ruby
edit :title
```

Each entry in the table description describes a column.  The format of each entry is: `"Column Name", "Resource method", "Options Hash"`.  For the default Roar interface, the `edit` column provides a link to edit the resource.

```ruby
column :author_name
column :"author.name"
column(:author) { |author| author.name }

date :published_at
column :published_at { |date| date.to_s(:long) }
```

Default column, will display the data.  Assuming that `post.author` points to a User object, and `post.author_name` delegates to `author.name`, all three of the author columns will produce the exact same result.  Similarly, `date` is just a shortcut to display a date with some formatting.

```ruby
delete
```

Delete provides a link to GET a view of the resource before the delete action is performed.  This provides an inline ajax confirmation, rather than the default javascript popup confirmation.  It also requires that you modify your routes to add the custom view, with `:member => { :delete => :get }`.  Use the standard rails link with javascript confirmation by using `destroy` in place of `delete`

```ruby
form do
```

In the same way you describe the collection interface with table, this lets you describe the edit view.  This view will be used for both new and edit (provide separate forms with `new_form` and `edit_form` in place of `form`).

```ruby
text_field :title
text_area :body, :name=>'Post Body'
check_box :published_at
```

All the standard rails form helpers are supported, and this form description will provide a view with three form fields -- a text input, text area, and a check box.  Pass in an optional label with the `:name` option.

```ruby
filters do
```

The filters block provides a way to search and filter the data in the collection view.  Currently supported filters, include:

```ruby
search :text, :fields=>[:title, :body]
```

This provides a text input box with a label of `Text` that will search the attributes passed in the list (`[:title, :body]`) with an sql `LIKE` query.

```ruby
recent_dates
```

Provides a radio widget field for selecting recent dates (today, this week, etc.)

```ruby
def index
 	...	
end
```
 
Since the roar interface is scoped to the "admin" subdomain, anything in the rest of the controller will operate as normal on any other domain.  So, the index action would be used to provide a public view to the post resource.

