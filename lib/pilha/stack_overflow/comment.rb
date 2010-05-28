module StackExchange
  module StackOverflow
    class Comment < Base
      extend Forwardable

      def_delegators :@struct, :comment_id, :creation_date, :owner, :post_id,
                     :post_type, :score, :body

      class << self 
        attr_reader :client

        def find_by_id(id, options = {})
          request('/comments/:id/', id, options)
        end

        def find_by_question_id(id, options = {})
          request('/questions/:id/comments', id, options)
        end

        def find_by_user_id(id, options = {})
          request('/users/:id/comments', id, options)
        end

        private
          def parse(response)
            response['comments'].each do |comment|
              parse_with_class(comment, 'owner', User)
            end
            parse_with_class(response, 'comments', Comment)
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
