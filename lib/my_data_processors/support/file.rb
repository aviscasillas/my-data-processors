require 'csv'
require 'my_data_processors/models/chunk'

module MyDataProcessors
  module Support
    module File
      def process_file(filename)
        CSV.foreach(filename, col_sep: "\t") do |line|
          yield(chunk_from_file_line(line))
        end
      end

      def chunk_from_file_line(line)
        attrs = { id: line[0], date: line[1], encdata: line[2] }
        MyDataProcessors::Models::Chunk.new(attrs)
      end
    end
  end
end
