require 'spec_helper'

describe StackExchange::StackOverflow::Comment do
  it 'should return a comment identified by its id' do 
    response = StackOverflow::Comment.find_by_id(1)

    response.total.should == 1
    response.page.should == 1
    response.pagesize.should == 30
    
    comment = response.comments.first
    comment.id.should == 1
    comment.creation_date.should == 1220688430
    comment.post_id.should == 35314
    comment.post_type.should == "answer"
    comment.score.should == 7
    comment.body.should == "not sure why this is getting downvoted -- it is correct! Double check it in your compiler if you don't believe him!"
  end
end
