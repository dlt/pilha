path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)

require 'rubygems'
require 'fakeweb'
require 'pilha'
require 'spec'
require 'pp'

include StackExchange
FIXTURES_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures'))
ROOT_URL = [StackOverflow::Client::URL.chomp('/'), StackOverflow::Client::API_VERSION].join '/'
FakeWeb.allow_net_connect = false

def register(options)
  url = api_method_url(options[:url])
  FakeWeb.register_uri(:get, url, :body => read_fixture(options[:body] + '.json.gz'))
end

def read_fixture(fixture)
  File.read(File.join(FIXTURES_PATH, fixture))
end

def api_method_url(method)
  ROOT_URL + '/' + method
end

['stats', 'badges' ].each do |method|
  register :url => method + '/', :body => method
end

register(:url => 'badges/9/', :body => 'badges_by_id')
register(:url => 'badges/9/?pagesize=50', :body => 'badges_by_id_page2')
register(:url => 'badges/tags/', :body => 'badges_tag_based')
register(:url => 'answers/666/', :body => 'answers_by_id')
register(:url => 'answers/555/', :body => 'answer_with_comments')
register(:url => 'comments/1/', :body => 'comments')
register(:url => 'users/1/answers/', :body => 'users_answers')
register(:url => 'questions/549/answers/', :body => 'answers_by_question_id')
register(:url => 'users/555/', :body => 'users_by_id')
