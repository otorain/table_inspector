# TableInspector
This is a Rails gem that allows you to print the definition of a table. While some gems (like [annotate_models](https://github.com/ctran/annotate_models)) are used to embed the table schema in the model file, they can be difficult to maintain and add unnecessary noise. This gem provides an alternative way to check the schema of a table without using `annotate_models`.

## Usage
Assuming there is a model call `User` which has `id` and `name` column, and has a unique index for `name`.
For print the definition of User, we can use: 
```ruby
require "table_inspector"

TableInspector.scan User
```

![TableInspect scan table](/img/table_inspector_scan_table_3.png)

It will print the table definition and all indexes.

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

You can print SQL type of column in the database by providing the `sql_type: true` option:

```ruby
TableInspector.scan User, sql_type: true
```
![Table Inspector scan table column with sql type](/img/table_inspector_scan_table_with_sql_type_3.png)

## Installation
Add this line to your application's Gemfile:

```ruby
gem "table_inspector"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install table_inspector
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
