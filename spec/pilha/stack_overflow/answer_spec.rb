require 'spec_helper'

describe StackExchange::StackOverflow::Answer do 

  it 'should return a answer identified by its id' do
    response = StackOverflow::Answer.find_by_id(666)
    response.total.should == 1
    response.pagesize.should == 30

    answer = response.answers.first
    answer.id.should == 666
    answer.accepted.should be_false
    answer.answer_comments_url.should == "/answers/666/comments"
    answer.question_id.should == 664

    user = answer.owner
    user.id.should == 58
    user.user_type.should == "registered"
    user.display_name.should == "cmcculloh"
    user.reputation.should == 2903
    user.email_hash.should == "298e0497aa6b76a573f17e6a2bb22dec"
  end

  it 'should include user association when option :include => :comments' do
    response = StackOverflow::Answer.find_by_id 555, :query => { :comments => true }
    response.answers.first.comments.size.should_not == 1
    comment = response.answers.first.comments.first
    comment.id.should == 278816
  end

  it 'should find all answers associated to a user' do
    response = StackOverflow::Answer.find_by_user_id 1

    response.answers.size.should == 30
    response.total.should == 165
    first_answer = response.answers.first
    first_answer.answer_id.should == 1250987
  end
end


