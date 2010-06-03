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

  it 'should find all tags used by an user identified by id' do
    response = StackOverflow::Tag.find_by_user_id(549)
    response.total.should == 151
    response.page.should == 1


    tag = response.tags.first
    tag.name.should == ".net"
    tag.count.should == 25
    tag.user_id.should == 549

    response.tags.should have(response.pagesize).tags

    response.tags.each do |tag|
      tag.user_id.should == 549
    end
  end

end
