
module TableInspector
  class ColumnValidator
    attr_accessor :klass, :column_name

    def initialize(klass, column_name)
      @klass = klass
      @column_name = column_name
    end

    def validate!
      return true if column_exists?

      puts column_is_not_exists_hint
      false
    end

    private

    def column_exists?
      klass.columns.find{|column| column.name == column_name.to_s }
    end

    def column_is_not_exists_hint
      puts "Column '#{column_name}' doesn't exist in table '#{klass.table_name}'!"
    end
  end
end