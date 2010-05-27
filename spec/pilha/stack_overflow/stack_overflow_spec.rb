require 'spec_helper'

describe StackOverflow::Client do
  before do
    @client = StackOverflow::Client.new
  end

  it 'should provide the api method path with its parameters' do
    url1 = @client.api_method_path('/foo/bar')
    url1.should == '/foo/bar/'

    url2 = @client.api_method_path('/foo/:bar/', :bar => 2)
    url2.should == '/foo/2/'

    url3 = @client.api_method_path('/foo/:bar/eggs', :bar => 'fried')
    url3.should == '/foo/fried/eggs/'
  end

  it 'should provide the full url for the api method' do 
    url = @client.api_method_url('/foo/bar', :query => { :name => 'smith', :lastname => 'smith'})
    url.should == @client.root_path + '/foo/bar/?lastname=smith&name=smith'

    url2 = @client.api_method_url('/foo/:bar', :bar => 2)
    url2.should == @client.root_path + '/foo/2/'

    url3 = @client.api_method_url('/foo/:bar/eggs', :bar => :fried, :query => { :with => 'bacon'} )
    url3.should == @client.root_path + '/foo/fried/eggs/?with=bacon'
  end

  describe 'when using #config for configuration setup' do
    before do
      @client = StackOverflow::Client.new
      @old_url = @client.url 

      StackOverflow::Client.config do |options|
        options.url = 'http://test.it'
        options.api_version = '666'
        options.api_key = 'key1234'
      end
    end

    after do
      StackOverflow::Client.config do |options|
        options.url = @old_url
      end
    end

    it 'should modify the api url' do
      StackOverflow::Statistics.client.url.should == 'http://test.it/'
    end

    it 'should modify the api version' do
      StackOverflow::Statistics.client.api_version.should == '666'
    end

    it 'should modify the api key' do
      StackOverflow::Statistics.client.api_key.should == 'key1234'
    end
  end
end
