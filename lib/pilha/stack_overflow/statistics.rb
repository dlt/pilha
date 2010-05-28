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

        def all(options = {})
          parse client.request('/stats', options)
        end

        private
          def parse(response)
            Statistics.new response['statistics'].first
          end
      end
    end
  end
end
