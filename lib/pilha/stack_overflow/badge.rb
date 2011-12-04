module StackExchange
  module StackOverflow
    class Badge < Base

      def_delegators :@struct, :badge_id, :rank, :name, :description,
                               :award_count, :tag_based, :badges_recipients_url

      class << self 

        def all(options = {})
          method = select_method(options)
          request(method, nil, options)
        end

        def select_method(options)
          tag_based = options[:tag_based] || options['tag_based']
          tag_based ? '/badges/tags' : '/badges'
        end

        def parse(response)
          parse_with_class(response, 'badges', Badge)
          OpenStruct.new response
        end
      end

      def id
        @struct.badge_id
      end
    end
  end
end
