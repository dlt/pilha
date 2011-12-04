module StackExchange
  module StackOverflow
    class Statistics < Base

      setup_delegators :@struct, :total_questions, :total_unanswered, :total_answers,
                              :total_comments, :total_votes, :total_badges,
                              :total_users, :questions_per_minute, :answers_per_minute,
                              :badges_per_minute, :api_version

      class << self
        def all(options = {})
          request('/stats', nil, options)
        end

        def parse(response)
          Statistics.new response['statistics'].first
        end
      end
    end
  end
end
