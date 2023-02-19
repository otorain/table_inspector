require "table_inspector/version"
require "table_inspector/railtie"
require "tty-table"

module TableInspector
  Error = Class.new(StandardError)

  extend self
  
  def scan(klass, column_name = nil)
    begin
      unless klass.is_a?(Class)
        klass = klass.constantize
      end
    rescue NameError
      raise_invalid_model_error!
    end

    raise_invalid_model_error! unless klass < ActiveRecord::Base

    if column_name
      scan_column(klass, column_name)
    else
      scan_table(klass)
    end
  end
  
  private

  def scan_column(klass, col_name)
    columns = klass.columns
    column = columns.find{|col| col.name == col_name.to_s}

    raise_column_not_found_error! unless column

    meta = extract_meta(column)
    header = meta.keys.map(&:upcase_first)

    table = TTY::Table.new(header: header)
    table << extract_meta(column).values

    puts table.render(:ascii)
  end

  def scan_table(klass)
    columns = klass.columns
    first_column_meta = extract_meta(columns.first)
    header = first_column_meta.keys.map(&:upcase_first)
    table = TTY::Table.new(header: header)

    columns.each do |column|
      table << extract_meta(column).values
    end

    puts table.render(:ascii)
  end

  def extract_meta(column)
    column.as_json.merge(column.sql_type_metadata.as_json).slice(*ordered_keys)
  end

  def ordered_keys
    %w[ name type limit null default precision scale comment]
  end

  def raise_invalid_model_error!
    raise Error, "Passed class is not a Model class!"
  end

  def raise_column_not_found_error!
    raise Error, "Column not found!"
  end
end
