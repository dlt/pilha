module StackExchange
  module StackOverflow
    class Answer
      extend Forwardable
      
      def_delegators :@struct, :answer_id, :accepted, :answer_comments_url, :question_id,
                     :owner, :creation_date, :last_activity_date, :up_vote_count, :down_vote_count,
                     :view_count, :score, :community_owned, :title, :comments

      class << self
        attr_reader :client

        def find_by_id(id, options = {})
          options.merge! :id => id
          response = client.get client.api_method_url('/answers/:id', options)
          
          answer_hash = response['answers'].first

          setup_associations!(response, answer_hash)
          OpenStruct.new(response)
        end

        private
          def setup_associations!(response, hash)
            hash['owner'] = User.new(hash['owner'])
            answer = Answer.new(hash)
            response['answers'] = [answer]
          end

          def setup_comments!(hash)
            if hash.key?('comments')
              hash['comments'] = hash['comments'].map {|c| Comment.new c}
            end
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

