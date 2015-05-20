require 'base64'
require 'json'

module MyDataProcessors
  module Models
    class Chunk
      attr_accessor :id, :date, :data

      def initialize(attrs = {})
        @id, @date, @data = attrs[:id], attrs[:date], attrs[:data]
        self.encdata = attrs[:encdata]
      end

      def encdata=(encdata)
        return unless encdata
        @data = decode(encdata)
      end

      def decode(enc_data)
        return unless enc_data

        json_data = Zlib::Inflate.new.inflate(
          ::Base64.decode64(enc_data)
        )

        JSON.parse(json_data)
      end
    end
  end
end
