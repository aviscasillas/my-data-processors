module MyDataProcessors
  module Support
    module TimeSlice
      def slice_range(hour_since, hour_to)
        since = slice_from_time(hour_since)
        to = slice_from_time(hour_to)
        (since..to).to_a
      end

      def slice_from_time(time)
        h, m = time.split(':')
        (96 * (h.to_i.hours + m.to_i.minutes)) / 24.hours
      end
    end
  end
end
