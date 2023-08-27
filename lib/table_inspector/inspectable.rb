
module TableInspector
  module Inspectable
    extend ActiveSupport::Concern

    module ClassMethods
      def ti(*args, **kwargs, &block)
        TableInspector.scan(self, *args, **kwargs, &block)
      end

      def ati(*args, **kwargs, &block)
        TableInspector.ascan(self, *args, **kwargs, &block)
      end
    end
  end
end