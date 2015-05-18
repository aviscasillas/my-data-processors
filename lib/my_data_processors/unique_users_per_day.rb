require 'my_data_processors/support/file'
require 'my_data_processors/support/callable'

module MyDataProcessors
  class UniqueUsersPerDay
    extend MyDataProcessors::Support::Callable
    include MyDataProcessors::Support::File

    attr_accessor :identifier, :filename, :result

    def initialize(options = {})
      @filename = options[:filename]
      @identifier = options[:identifier]
    end

    def process!
      process_file(filename) do |chunk|
        process_chunk(chunk)
      end

      result
    end

    def process_chunk(chunk)
      return unless chunk.id == identifier
      result[chunk.date] = chunk.data.keys.uniq.count
    end

    def result
      @result ||= {}
    end
  end
end
