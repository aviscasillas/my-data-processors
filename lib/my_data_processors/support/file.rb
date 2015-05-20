require 'my_data_processors/models/chunk'

module MyDataProcessors
  module Support
    module File
      def process_file(filename, &block)
        buffer = []
        ::File.foreach(filename).each do |line|
          buffer << line

          next if line.length > 3

          block.call(chunk_from_file_line(buffer.join))
          buffer.clear
        end
      end

      def chunk_from_file_line(line)
        args = line.split("\t").compact
        attrs = { id: args[0], date: args[1], encdata: args[2] }

        MyDataProcessors::Models::Chunk.new(attrs)
      end
    end
  end
end
