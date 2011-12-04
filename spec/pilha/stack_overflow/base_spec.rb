require "spec_helper"

describe StackExchange::StackOverflow::Base do
  it "should allow extended classes to know which of its methods are provided by the SO API" do
    klass = Class.new(StackExchange::StackOverflow::Base) do
      setup_delegators *%w[foo bar baz]
    end

    klass.api_methods.should == %w[foo bar baz]
  end
end
