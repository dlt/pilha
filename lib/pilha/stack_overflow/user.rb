module StackExchange
  module StackOverflow

    class User 
      extend Forwardable

      def_delegators :@struct, :user_id, :user_type, :creation_date, :display_name,
                               :reputation, :email_hash, :age, :last_access_date,
                               :website_url, :location, :about_me, :question_count,
                               :answer_count, :view_count, :up_vote_count, :down_vote_count,
                               :user_questions_url, :user_answers_url, :user_favorites_url,
                               :user_tags_url, :user_badges_url, :user_timeline_url,
                               :user_mentioned_url, :user_comments_url, :user_reputation_url,
                               :badge_counts

      def initialize(hash)
        @struct = OpenStruct.new hash
      end

      def id
        @struct.user_id
      end

      class << self 

        attr_reader :client

        def find_by_badge_id(id, query_options = {})
          response = client.get client.api_method_url('/badges/:id', :id => id, :query => query_options)
          users = response['users'].map { |user| User.new(user) }
          response['users'] = users
          OpenStruct.new response
        end
      end
    end
  end
end
