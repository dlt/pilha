module StackExchange
  module StackOverflow
    class Tag < Base
      extend Forwardable

      def_delegators :@struct, :name, :count

      class << self
        def all(options = {})
          request('/tags', nil, options)
        end


        def parse(response)
          parse_with_class(response, 'tags', Tag)
          OpenStruct.new response
        end
      end

      def initialize(hash)
        @struct = OpenStruct.new hash
      end
    end
  end
end
