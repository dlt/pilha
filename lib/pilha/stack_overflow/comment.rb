module StackExchange
  module StackOverflow
    class Comment < Base

      def_delegators :@struct, :comment_id, :creation_date, :owner, :post_id,
                     :post_type, :score, :body

      class << self 

        def find(id, options = {})
          request('/comments/:id/', id, options)
        end

        def find_by_question_id(id, options = {})
          request('/questions/:id/comments', id, options)
        end

        def find_by_user_id(id, options = {})
          if options[:to_user]
            request('/users/:id/comments/:to_user', id, options)
          else
            request('/users/:id/comments', id, options)
          end
        end

        def find_by_mentioned_user_id(id, options = {})
          request('/users/:id/mentioned', id, options) 
        end

        def parse(response)
          response['comments'].each do |comment|
            parse_with_class(comment, 'owner', User)
            parse_with_class(comment, 'reply_to_user', User)
          end
          parse_with_class(response, 'comments', Comment)
          OpenStruct.new response
        end
      end

      def id
        @struct.comment_id
      end

      def mentioned_user
        @struct.reply_to_user
      end
    end
  end
end
