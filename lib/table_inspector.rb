require "table_inspector/version"
require "table_inspector/railtie"
require "terminal-table"
require "table_inspector/text"
require "table_inspector/table"
require "table_inspector/terminal_table"
require "table_inspector/indexes"
require "table_inspector/column"
require "table_inspector/presenter"
require "table_inspector/presenter/sqlite3"
require "table_inspector/presenter/postgresql"
require "table_inspector/presenter/mysql2"
require "table_inspector/model_validator"
require "table_inspector/column_validator"
require "table_inspector/presenter_option"
require "table_inspector/inspectable"

module TableInspector
  extend self
  mattr_accessor :style

  # options:
  #   - sql_type: pass "true" print sql type, pass "false" not print sql type, default is false
  #   - comment_only: pass "true" print comment only, pass "false" will print all column info, default is false
  def ascan(klass, column_name = nil, **options)
    scan(klass, column_name, colorize: true, **options)
  end

  # options:
  #   - sql_type: pass "true" print sql type, pass "false" not print sql type, default is false
  #   - comment_only: pass "true" print comment only, pass "false" will print all column info, default is false
  #   - colorize: pass "true" print colorful scheme, pass "false" will print scheme without color, default is false
  def scan(klass, column_name = nil, colorize: false, **options)
    klass = classify!(klass)

    return unless klass
    return unless validate!(klass, column_name)

    presenter_options = PresenterOption.new({ **options, colorize: colorize })
    render(klass, column_name, presenter_options)
  end

  private

  def classify!(klass)
    return klass if klass.is_a?(Class)
    klass.to_s.classify.constantize
  rescue NameError
    puts invalid_model_name_hint(klass.inspect)
  end

  def validate!(klass, column_name)
    model_validator = ModelValidator.new(klass)
    return model_validator.validate! unless column_name

    column_validator = ColumnValidator.new(klass, column_name)
    model_validator.validate! && column_validator.validate!
  end

  def render(klass, column_name, presenter_option)
    if column_name
      Column.new(klass, column_name, presenter_option).render
    else
      Table.new(klass, presenter_option).render
    end
  end

  def invalid_model_name_hint(klass)
    "'#{klass}' cannot be transformed to a valid model class."
  end
end
