module StackExchange
  module StackOverflow

    class Statistics

      extend Forwardable

      def_delegators :@struct, :total_questions, :total_unanswered, :total_answers,
                              :total_comments, :total_votes, :total_badges,
                              :total_users, :questions_per_minute, :answers_per_minute,
                              :badges_per_minute, :api_version

      def initialize(hash)
        @struct = OpenStruct.new hash
      end

      class << self
        attr_reader :client

        def all
          response = client.get client.api_method_url('/stats')
          stats = response['statistics'].first
          Statistics.new stats
        end
      end

    end
  end
end
