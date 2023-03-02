
module TableInspector
  class Validator
    def initialize(klass, column_name)
      @klass = klass
      @column = column_name
    end

    def validate!

      if column_name && !validate_column(klass, column_name)
        puts column_is_not_exists_hint(klass, column_name)
        return
      end

      true
    end

    private

    def is_active_record_class?(klass)
      klass < ActiveRecord::Base
    end

    def validate_column(klass, column_name)
      klass.columns.find{|column| column.name == column_name.to_s }
    end

    def not_a_model_class_hint(klass)
      "#{klass} is not a model klass"
    end

    def column_is_not_exists_hint(klass, column_name)
      puts "Column '#{column_name}' doesn't exists in table '#{klass.table_name}'"
    end
  end
end