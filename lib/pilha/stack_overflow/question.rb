module StackExchange
  module StackOverflow
    class Question < Base
      extend Forwardable

      def_delegators :@struct, :question_id, :tags, :creation_date, :last_activity_date,
                               :up_vote_count, :down_vote_count, :view_count, :score,
                               :community_owned, :title, :body, :answers, :answer_count,
                               :accepted_answer_id, :favorite_count, :question_timeline_url,
                               :question_comments_url, :question_answers_url, :owner

      class << self 
        attr_reader :client

        def find(id, options = {})
          request('/questions/:id/', id, options).questions.first
        end

        def find_by_user_id(id, options = {})
          request('/users/:id/questions', id, options)
        end

        def find_favorites_by_user_id(id, options = {})
          request('/users/:id/favorites', id, options) 
        end

        def parse(response)
          response['questions'].each do |comment|
            parse_with_class(comment, 'owner', User)
          end
          parse_with_class(response, 'questions', Question)
          OpenStruct.new response
        end
      end

      def initialize(hash)
        @struct = OpenStruct.new hash
      end

      def id
        @struct.question_id
      end
    end
  end
end
