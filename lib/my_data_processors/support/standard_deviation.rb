module MyDataProcessors
  module Support
    module StandardDeviation
      def standard_deviation
        Math.sqrt(sample_variance)
      end

      def accumulate(value)
        items << value

        @sum ||= 0
        @sum += value
      end

      private

      def mean
        @mean ||= @sum / items.length.to_f
      end

      def sample_variance
        deviations_sum = items.reduce(0) { |a, e| a + (e - mean)**2 }
        deviations_sum / (items.length - 1).to_f
      end

      def items
        @items ||= []
      end
    end
  end
end
