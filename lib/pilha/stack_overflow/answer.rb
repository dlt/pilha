module StackExchange
  module StackOverflow
    class Answer
      extend Forwardable
      
      def_delegators :@struct, :answer_id, :accepted, :answer_comments_url, :question_id,
                     :owner, :creation_date, :last_activity_date, :up_vote_count, :down_vote_count,
                     :view_count, :score, :community_owned, :title, :comments

      class << self
        attr_reader :client

        def find(id, options = {})
          options.merge! :id => id
          response = client.request('/answers/:id', options)
          response.answers.first
        end

        def find_by_user_id(id, options = {})
          options.merge! :id => id
          response = client.request('/users/:id/answers', options)
          OpenStruct.new(parse response)
        end

        def find_by_question_id(id, options = {})
          options.merge! :id => id
          response = client.request('/questions/:id/answers', options)
          OpenStruct.new(parse response)
        end

        private
          def setup_associations!(response, hash)
            setup_comments! hash
            setup_owner! hash
          end

          def setup_comments!(hash)
            if hash['comments']
              hash['comments'] = hash['comments'].map {|c| Comment.new c }
            end
          end

          def setup_owner!(hash)
            if hash['owner']
              hash['owner'] = User.new(hash['owner'])
            end
          end

          def setup_answers!(response)
            if response['answers']
              response['answers'] = response['answers'].map { |a| Answer.new a }
            end
          end

          def parse(response)
            response['answers'].each do |answer_hash|
              setup_associations!(response, answer_hash)
            end
            setup_answers! response
            response
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

