module StackExchange
  module StackOverflow
    class Base 

      class << self
        def parse_with_class(hash, key, klass)
          case hash[key]
          when Hash
            hash[key] = klass.new(hash[key])
          when Array
            hash[key] = hash[key].map { |value| klass.new(value) }
          end
        end

        def request(path_pattern, id, options)
          options.merge! :id => id if id
          parse client.request(path_pattern, options)
        end

        def client
          StackExchange::StackOverflow::Client.instance
        end
      end

      def initialize(hash)
        @struct = OpenStruct.new hash
      end
    end
  end
end
