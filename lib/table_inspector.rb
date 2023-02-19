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

  Error = Class.new(StandardError)

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
      Column.new(klass, column_name, sql_type: sql_type).render
    else
      Table.new(klass, sql_type: sql_type).render
    end
  end
  
  private

  def raise_invalid_model_error!
    raise Error, "Passed class is not a Model class!"
  end
end
