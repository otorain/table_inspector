require "table_inspector/version"
require "table_inspector/railtie"
require "tty-table"
require "table_inspector/table"
require "table_inspector/grid"
require "table_inspector/indexes"
require "table_inspector/text"
require "table_inspector/column"
require "table_inspector/presenter"

module TableInspector
  extend self

  def scan(klass, column_name = nil, sql_type: false)
    begin
      unless klass.is_a?(Class)
        klass = klass.to_s.classify.constantize
      end
    rescue NameError
      puts invalid_model_name_hint(klass.inspect)
      return
    end

    unless klass < ActiveRecord::Base
      puts not_a_model_class_hint(klass)
      return
    end

    if column_name && !validate_column(klass, column_name)
      puts column_is_not_exists_hint(klass, column_name)
      return
    end

    if column_name
      Column.new(klass, column_name, sql_type: sql_type).render
    else
      Table.new(klass, sql_type: sql_type).render
    end
  end
  
  private

  def validate_column(klass, column_name)
    klass.columns.find{|column| column.name == column_name.to_s }
  end

  def invalid_model_name_hint(klass)
    "'#{klass}' can be transform to a model class."
  end

  def not_a_model_class_hint(klass)
    "#{klass} is not a model klass"
  end

  def column_is_not_exists_hint(klass, column_name)
    puts "Column '#{column_name}' doesn't exists in table '#{klass.table_name}'"
  end
end
