# TableInspector
![Test coverage](https://img.shields.io/badge/Test_coverage-99.65%25-green)
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
TableInspector.scan User
```

![TableInspect scan table](/img/table_inspector_scan_table_3.png)

This will print the scheme of table and indexes. 
If the table content is too long and appears messy, you can adjust the scaling of the terminal window or use the `TableInspector.scan(User, :name)` syntax to print a specific column. 

Alternatively, you can use `TableInspector.ascan` to print a more colorful table(`ascan` means `awesome scan`) :
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

If you are using Ruby version 2.7.0 or later, you can define a helper method directly in the model itself by editing the `app/models/application_record.rb` file and adding the code provided above:
```ruby
# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  # ...

  def self.ti(...)
    TableInspector.scan(self, ...) if const_defined?("TableInspector")
  end

  def self.ati(...)
    TableInspector.ascan(self, ...) if const_defined?("TableInspector")
  end
  
  # ...
end
```
Then you will be able to achieve the same effect as `scan` and `ascan` do by invoking `ti` and `ati` on the model class:

```ruby
# Same as TableInspector.scan User
User.ti

# Same as TableInspector.ascan User
User.ati
```

You can print the database column type by providing the `sql_type: true` option:
```ruby
User.ti sql_type: true
# or 
TableInspector.scan User, sql_type: true
```
![Table Inspector scan table column with sql type](/img/table_inspector_scan_table_with_sql_type_3.png)

Additionally, if you want to print the comments associated with the columns of the table, you can use the `comment_only` option:
```ruby
User.ti comment_only: true
# or
TableInspector.scan User, comment_only: true
```
![Table Inspector scan table comment only](/img/table_inspector_scan_table_comment_only.png)
If the `sql_type: true` option is also provided, the sql_type option will be omitted.

## Style
To change the style of the table by setting the `TableInspector.style` in `config/initializers/table_inspector.rb`(create it if not exists): 
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
