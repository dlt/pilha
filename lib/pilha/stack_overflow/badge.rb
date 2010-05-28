module StackExchange
  module StackOverflow
    class Badge 

      extend Forwardable

      def_delegators :@struct, :badge_id, :rank, :name, :description,
                               :award_count, :tag_based, :badges_recipients_url

      class << self 
        attr_reader :client

        def all(options = {})
          method = select_method(options)
          parse client.request(method, options)
        end

        def select_method(options)
          tag_based = options[:tag_based] || options['tag_based']
          tag_based ? '/badges/tags' : '/badges'
        end

        def parse(response)
          response['badges'] = response['badges'].map { |badge| Badge.new badge }
          OpenStruct.new response
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
