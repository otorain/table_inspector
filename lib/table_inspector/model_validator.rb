
module TableInspector
  class ModelValidator
    attr_accessor :klass

    def initialize(klass)
      @klass = klass
    end

    def validate!
      return true if is_model_class?

      puts not_a_model_class_hint
      false
    end

    private

    def is_model_class?
      klass < ActiveRecord::Base
    end

    def not_a_model_class_hint
      "#{klass} is not a model class!"
    end
  end
end