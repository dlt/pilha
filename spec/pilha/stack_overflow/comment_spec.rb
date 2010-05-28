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

  it 'should get comments associated with a question identified by id' do
    response = StackOverflow::Comment.find_by_question_id 549
    response.total.should == 1

    comment = response.comments.first
    comment.id.should == 858028
    comment.creation_date.should == 1245970256

    comment.post_id.should == 549
    comment.post_type.should == "question"
    comment.score.should be_zero
    comment.body.should == "Why exclude HTTP Basic Authentication? It can work in HTML Forms via Ajax: <a href=\"http://www.peej.co.uk/articles/http-auth-with-html-forms.html\" rel=\"nofollow\">peej.co.uk/articles/&hellip;</a>"

    comment.owner.id.should == 52963
    comment.owner.user_type.should == "registered"
    comment.owner.display_name.should == "system PAUSE"
    comment.owner.reputation.should == 2143
    comment.owner.email_hash.should == "4e47334ae70850cd210b952cdb0cb9be"
  end

  it 'should get comments associated with a user identified by id' do
    response = StackOverflow::Comment.find_by_user_id 549
    response.total.should == 117

    comment = response.comments.first
    comment.id.should == 2739275
    comment.creation_date.should == 1272292520
    comment.post_id.should == 2580831
    comment.post_type.should == "answer"
    comment.score.should be_zero
    comment.body.should == "Thanks so much for this.  I had a devilish time finding this in JetBrains' documentation."

    comment.owner.id.should == 549
    comment.owner.user_type.should == "registered"
    comment.owner.display_name.should == "Josh Kodroff"
    comment.owner.reputation.should == 1542
    comment.owner.email_hash.should == "9e7ef08258f04dab37b43842d261aea8"
  end
end
