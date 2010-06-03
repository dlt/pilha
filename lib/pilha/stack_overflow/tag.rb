module StackExchange
  module StackOverflow
    class Tag < Base
      extend Forwardable

      def_delegators :@struct, :name, :count, :user_id

      class << self
        def all(options = {})
          request('/tags', nil, options)
        end

        def find_by_user_id(id, options = {})
          request('/users/:id/tags', id, options)
        end

        def parse(response)
          parse_with_class(response, 'tags', Tag)
          OpenStruct.new response
        end
      end
    end
  end
end
