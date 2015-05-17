require 'my_data_processors/models/chunk'

module MyDataProcessors
  module Support
    module File
      def process_file(filename, &block)
        buffer = []

        ::File.foreach(filename).each do |line|
          buffer << line

          next if line.length > 3

          args = buffer.join.split("\t").compact
          buffer.clear

          block.call(MyDataProcessors::Models::Chunk.new(*args))
        end
      end
    end
  end
end
