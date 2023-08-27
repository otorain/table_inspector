# TableInspector
![Test coverage](https://img.shields.io/badge/Test_coverage-99.65-green)
![Release version](https://img.shields.io/badge/Release-v0.6.0-green)
![Workflow badge](https://github.com/otorain/table_inspector/actions/workflows/run_test.yml/badge.svg)

This is a Rails gem that allows you to print the structure of a database table by providing a model class.
It functions similar to [annotate_models](https://github.com/ctran/annotate_models), but offers an alternative way to checking the table schema.
The print function is based on [terminal-table](https://github.com/tj/terminal-table)

This doc is about version 0.6.0. For version 0.5.0, please see [here](https://github.com/otorain/table_inspector/tree/v0.5.5)

## Installation
Add this line to your application's Gemfile:

```ruby
gem "table_inspector", "~> 0.6.0"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install table_inspector
```

## Usage
Assuming there is a model call `User` which has `id` and `name` column, and has a unique index for `name`.
For print the table structure of User, we can use: 
```ruby
require "table_inspector"

TableInspector.scan User
```

![TableInspect scan table](/img/table_inspector_scan_table_3.png)

It will print the scheme of table and indexes. 
(If the table content is too long, It may be printed messy. You can adjust the scaling of the terminal window to fix it. 
Alternatively, you can use `TableInspector.scan(User, :name)` to print a specific column)

Or you can use `TableInspector.ascan` to print more colorful table(`ascan` means `awesome scan`) :
```ruby
TableInspector.ascan User
```
![TableInspect ascan table](/img/table_inspector_ascan_table_3.png)

And to print a specific column by:

```ruby
TableInspector.scan User, :name
```
![Table Inspector scan column](/img/table_inspector_scan_column_3.png)

It will print the column definition and which indexes that contains this column.

**It is recommended to include `TableInspector::Inspectable` in `app/models/application_record.rb` and use `ti` or `ati` method to print the table definition: **
```ruby
# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  # Add this line
  include TableInspector::Inspectable

  # ...
end
```
and call:
```ruby
# Same as TableInspector.scan User
User.ti

# Same as TableInspector.ascan User
User.ati
```
The module `TableInspector::Inspectable` only defines two class methods: `ti` and `ati`, which delegate to `TableInspector.scan` and `TableInspector.ascan` respectively.

You can print the database column type by providing the `sql_type: true` option:
```ruby
User.ti sql_type: true
# or 
TableInspector.scan User, sql_type: true
```
![Table Inspector scan table column with sql type](/img/table_inspector_scan_table_with_sql_type_3.png)

To print comment column only for the table, use `comment_only: true` option:
```ruby
User.ti comment_only: true
# or
TableInspector.scan User, comment_only: true
```
![Table Inspector scan table comment only](/img/table_inspector_scan_table_comment_only.png)
If the `sql_type: true` option is also provided, the sql_type option will be omitted.

## Style
You can change the style of the table by setting the `TableInspector.style` in `config/initalizers/table_inspector.rb`(create it if not exists): 
```ruby
# config/initializers/table_inspector.rb

TableInspector.style = { border: :unicode }
# TableInspector.style = { border: :ascii } # default border style
# TableInspector.style = { border: :unicode_round }
# TableInspector.style = { border: :unicode_thick_edge } 
# TableInspector.style = { border: :markdown }
```
You can use other options available in `TerminalTable#style` of the [terminal-table](https://github.com/tj/terminal-table) 

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
