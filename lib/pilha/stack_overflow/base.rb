module StackExchange
  module StackOverflow
    class Base 
      extend Forwardable

      class << self
        attr_reader :api_methods

        def setup_delegators(*delegators)
          @api_methods = delegators
          def_delegators *delegators
        end

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

      def api_methods
        self.class.api_methods 
      end

    end
  end
end
