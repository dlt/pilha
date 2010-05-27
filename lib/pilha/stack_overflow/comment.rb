module StackExchange
  module StackOverflow
    class Comment 
      extend Forwardable

      def_delegators :@struct, :comment_id, :creation_date, :owner, :post_id,
                     :post_type, :score, :body

      class << self 
        attr_reader :client

        def find_by_id(id, options = {})
          options.merge! :id => id
          response = client.get client.api_method_url('/comments/:id/', options)

          comment = Comment.new(response['comments'].first)
          response['comments'] = [comment]

          OpenStruct.new response
        end
      end

      def initialize(hash)
        @struct = OpenStruct.new hash
      end

      def id
        @struct.comment_id
      end
    end
  end
end
