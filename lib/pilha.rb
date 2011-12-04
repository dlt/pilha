path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)

require 'zlib'
require 'json'
require 'open-uri'
require 'forwardable'
require 'ostruct'

require 'pilha/stack_overflow/base'
require 'pilha/stack_overflow/tag'
require 'pilha/stack_overflow/user'
require 'pilha/stack_overflow/badge'
require 'pilha/stack_overflow/answer'
require 'pilha/stack_overflow/comment'
require 'pilha/stack_overflow/question'
require 'pilha/stack_overflow/statistics'

module StackExchange
  module StackOverflow

    VERSION = '0.2.2'

    class Client
      URL = 'http://api.stackoverflow.com/'
      API_VERSION = '1.1'

      attr_reader :url
      attr_reader :api_version
      attr_reader :api_key

      class << self 

        def config(&block)
          options = OpenStruct.new
          yield options if block_given?
          @client = Client.new(options)
        end

        def instance
          @client 
        end

      end

      def initialize(options = OpenStruct.new)
        @url = normalize(options.url || URL)
        @api_version = options.api_version || API_VERSION
        @api_key = options.api_key 
      end

      def api_method_path(pattern, options = {})
        pattern = normalize(pattern)

        pattern.scan(/:(\w+)/).each do |part|
          val = part.first
          pattern.sub!(":" + val, options[val.to_sym].to_s)
        end

        pattern
      end

      def api_method_url(method, options = {})
        options.merge! :api_key => api_key if api_key
        root_path + api_method_path(method, options) + query_string(options)
      end

      def get(url)
        JSON.parse(Zlib::GzipReader.new(open(url)).read)
      end

      def root_path
        url + api_version
      end

      def request(path, options)
        get api_method_url(path, options)
      end

      private
        def query_string(options)
          params = options[:query] || options[:conditions]
          return '' unless params

          params = params.sort_by { |k, v| k.to_s }
          pairs  = params.map { |k, v| "#{k}=#{v}" }

          '?' + pairs.join('&')
        end

        def normalize(url)
          url.end_with?('/') ? url : url + '/'
        end
    end
  end
end
