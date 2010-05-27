module StackExchange
  module StackOverflow
    class Badge 

      extend Forwardable

      def_delegators :@struct, :badge_id, :rank, :name, :description,
                               :award_count, :tag_based, :badges_recipients_url

      class << self 
        attr_reader :client

        def all
          response = client.get client.api_method_url('/badges')
          badges = response['badges']
          badges.map { |badge| Badge.new badge }
        end
      end

      def initialize(hash)
        @struct = OpenStruct.new hash
      end

      def id
        @struct.badge_id
      end
    end
  end
end
