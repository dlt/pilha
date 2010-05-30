module StackExchange
  module StackOverflow
    class User < Base
      extend Forwardable

      def_delegators :@struct, :user_id, :user_type, :creation_date, :display_name,
                               :reputation, :email_hash, :age, :last_access_date,
                               :website_url, :location, :about_me, :question_count,
                               :answer_count, :view_count, :up_vote_count, :down_vote_count,
                               :user_questions_url, :user_answers_url, :user_favorites_url,
                               :user_tags_url, :user_badges_url, :user_timeline_url,
                               :user_mentioned_url, :user_comments_url, :user_reputation_url,
                               :badge_counts

      class << self 

        attr_reader :client

        def all(options = {})
          request('/users', nil, options)
        end

        def find_by_badge_id(id, options = {})
          request('/badges/:id', id, options)
        end

        def find(id, options = {})
          request('/users/:id', id, options).users.first
        end

        def parse(response)
          parse_with_class(response, 'users', User)
          OpenStruct.new response
        end
      end

      def initialize(hash)
        @struct = OpenStruct.new hash
      end

      def id
        @struct.user_id
      end
    end
  end
end
