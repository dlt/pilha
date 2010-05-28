module StackExchange
  module StackOverflow
    class Answer < Base
      extend Forwardable
      
      def_delegators :@struct, :answer_id, :accepted, :answer_comments_url, :question_id,
                     :owner, :creation_date, :last_activity_date, :up_vote_count, :down_vote_count,
                     :view_count, :score, :community_owned, :title, :comments

      class << self
        attr_reader :client

        def find(id, options = {})
          request('/answers/:id', id, options).answers.first
        end

        def find_by_user_id(id, options = {})
          request('/users/:id/answers', id, options)
        end

        def find_by_question_id(id, options = {})
          request('/questions/:id/answers', id, options)
        end

        def parse(response)
          response['answers'].each do |answer|
            parse_with_class(answer, 'comments', Comment)
            parse_with_class(answer, 'owner', User)
          end
          parse_with_class(response, 'answers', Answer)
          OpenStruct.new response
        end
      end

      def initialize(hash)
        @struct = OpenStruct.new hash
      end

      def id
        @struct.answer_id
      end
    end
  end
end

