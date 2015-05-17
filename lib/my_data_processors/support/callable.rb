module MyDataProcessors
  module Support
    module Callable
      def call(*args)
        new(*args).process!.result
      end
    end
  end
end
