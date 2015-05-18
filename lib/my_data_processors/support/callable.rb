module MyDataProcessors
  module Support
    module Callable
      def call(*args)
        new(*args).process!
      end
    end
  end
end
