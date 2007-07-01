CSS: screen.css
Use numbered headers: true
HTML use syntax: true

{:ruby:     lang=ruby code_background_color='#EAEADA'}
{:shell:    lang=sh code_background_color='#efefff'}
{:markdown: code_background_color='#ffefef'}
{:html:     lang=xml}

[Up](index.html)

Roar: Documentation
===================

* This list will contain the toc (it doesn't matter what you write here)
{:toc}

* * *

roar
----


Define a roar interface.

#### Options

**`:subdomain`**

	# This defines a roar interface that only responds if
	# the first subdomain is 'admin'
	roar :subdomain => "admin" do ... end
{:ruby}


**`:layout`**

	# Override the layout for all roar actions.
	# Default is 'roar'
	roar :layout => "custom" do ... end
{:ruby}

**`:parent`**

	# Define parents of this resource
	# Takes a symbol, or list of symbols
	roar :parent=>[:forum,:topic] do ... end
{:ruby}

**`:view`**

	# The view is used to allow for customized views
	roar :view=>'custom' do ... end

#### Query options

**`per_page`** -- Number of resources per page

	 per_page 10
{:ruby}

**`include`** -- Add an include statement to the query
	
	include [:user]
{:ruby}

**`order`** -- The sql order

	order "created_at DESC"
{:ruby}

table
-----

With `table` you define the main admin table.

	table do
		# Define the table here
	end
{:ruby}

**`column`** -- Default column, displays text

	column :title
	column "user.name"
	column "user.name", :name => "User"
{:ruby}


**`edit`** -- Link to the edit view

	edit :title
	edit "user.name"
	edit "user.name", :name => "User"
{:ruby}


**`has_many`**

	has_many :users
{:ruby}

**`delete`**

	delete
{:ruby}

**`destroy`**

	destroy
{:ruby}

**`inline_select`**

	inline_select :status, :choices=>Status.to_select
{:ruby}


form
----

### Rails default helpers:

**`text_field`**

**`password_field`**

**`text_area`**  

**`date_select`**  

**`datetime_select`**  

**`check_box`**

**`select_field`**
  
### `fieldset`

### Advanced helpers:

**`template`**

**`auto_complete`**

**`select_and_add`**

**`relationship`**
  
### Specifying actions:

**`:save`**

**`:save_and_continue_editing`**

**`:save_and_add_another`**

**`:delete`**

**`:destroy`**

filters
-------

Filters can be passed in with a block:

	filters do
	  search :text, :fields => [:title,:body]
	  recent_dates :created_at
	end
{:ruby}    

Or, one by one, like

	filter :search, :text, :fields => [:title,:body]
	filter :recent_dates, :created_at
{:ruby}