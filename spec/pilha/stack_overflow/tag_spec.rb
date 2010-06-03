require 'spec_helper'

describe StackExchange::StackOverflow::Tag do

  it 'should get all tags' do
    response = StackOverflow::Tag.all
    response.total.should == 29199
    response.pagesize.should == 70
    response.page == 1

    response.tags.should have(response.pagesize).tags

    tag = response.tags.first
    tag.name.should == "c#"
    tag.count.should == 84875
  end

end
