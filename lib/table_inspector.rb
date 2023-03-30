require "table_inspector/version"
require "table_inspector/railtie"
require "terminal-table"
require "table_inspector/table"
require "table_inspector/grid"
require "table_inspector/indexes"
require "table_inspector/text"
require "table_inspector/column"
require "table_inspector/presenter"
require "table_inspector/model_validator"
require "table_inspector/column_validator"

module TableInspector
  extend self

  def ascan(klass, column_name = nil, sql_type: false)
    klass = classify!(klass)

    return unless klass
    return unless  validate!(klass, column_name)

    render(klass, column_name, sql_type, colorize: true)
  end

  def scan(klass, column_name = nil, sql_type: false)
    klass = classify!(klass)

    return unless klass
    return unless validate!(klass, column_name)

    render(klass, column_name, sql_type)
  end

  private

  def classify!(klass)
    begin
      unless klass.is_a?(Class)
        klass = klass.to_s.classify.constantize
      end
    rescue NameError
      puts invalid_model_name_hint(klass.inspect)
      return
    end

    klass
  end

  def validate!(klass, column_name)
    model_validator = ModelValidator.new(klass)
    unless column_name
      return model_validator.validate!
    end

    column_validator = ColumnValidator.new(klass, column_name)
    model_validator.validate! && column_validator.validate!
  end

  def render(klass, column_name, sql_type, colorize: false)
    if column_name
      Column.new(klass, column_name, sql_type: sql_type, colorize: colorize).render
    else
      Table.new(klass, sql_type: sql_type, colorize: colorize).render
    end
  end

  def invalid_model_name_hint(klass)
    "'#{klass}' can be transform to a model class."
  end
end
