require "table_inspector/version"
require "table_inspector/railtie"
require "tty-table"

module TableInspector
  Error = Class.new(StandardError)

  extend self
  
  def scan(klass, column_name = nil, sql_type: false)
    begin
      unless klass.is_a?(Class)
        klass = klass.constantize
      end
    rescue NameError
      raise_invalid_model_error!
    end

    raise_invalid_model_error! unless klass < ActiveRecord::Base

    if column_name
      scan_column(klass, column_name, sql_type: sql_type)
    else
      scan_table(klass, sql_type: sql_type)
    end
  end
  
  private

  def scan_column(klass, col_name, sql_type: false)
    columns = klass.columns
    column = columns.find{|col| col.name == col_name.to_s}

    raise_column_not_found_error! unless column

    meta = extract_meta(column, sql_type: sql_type)
    header = meta.keys.map(&:upcase_first)

    table = TTY::Table.new(header: header)
    table << extract_meta(column, sql_type: sql_type).values

    puts table.render(:ascii)
  end

  def scan_table(klass, sql_type: false )
    columns = klass.columns
    first_column_meta = extract_meta(columns.first, sql_type: sql_type)
    header = first_column_meta.keys.map(&:humanize)
    table = TTY::Table.new(header: header)

    columns.each do |column|
      table << extract_meta(column, sql_type: sql_type).values
    end

    puts "\n"
    puts "#{bold("Table")}: #{klass.table_name}"
    puts "\n"
    puts table.render(:ascii)
    puts "\n"
    print_indexes(klass)
  end

  def extract_meta(column, sql_type: false)
    column.as_json.merge(column.sql_type_metadata.as_json).slice(*ordered_keys(sql_type: sql_type))
  end

  def ordered_keys(sql_type: false)
    %w[ name type limit null default precision scale comment].tap do |keys|
      keys << "sql_type" if sql_type
    end
  end

  def raise_invalid_model_error!
    raise Error, "Passed class is not a Model class!"
  end

  def raise_column_not_found_error!
    raise Error, "Column not found!"
  end

  def list_indexes(klass)
    table_name = klass.table_name
    connection.indexes(table_name)
  end

  def print_indexes(klass)
    table = TTY::Table.new
    indexes = list_indexes(klass)
    indexes.each do |index|
      table << [
        index.name,
        "[#{index.columns.join(', ')}]",
        index.unique ? "UNIQUE" : ""
      ]
    end

    puts bold("Indexes")
    puts "\n"
    puts table.render
  end

  def connection
    @_connection ||= ActiveRecord::Base.connection
  end

  def bold(str)
    "\033[1m#{str}\033[0m"
  end
end
