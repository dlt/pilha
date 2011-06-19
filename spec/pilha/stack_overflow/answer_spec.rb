require 'spec_helper'

describe StackExchange::StackOverflow::Answer do 
  it 'should return all answers' do
    response = StackOverflow::Answer.all
    response.pagesize.should == 30
    response.page.should == 1
    response.total.should == 3975771

    answer = response.answers.first
    answer.accepted.should be_false
    answer.title.should == "Reading a text file - fopen vs. ifstream"
  end

  it 'should return a answer identified by its id (without body)' do
    answer = StackOverflow::Answer.find(666)

    answer.id.should == 666
    answer.accepted.should be_false
    answer.answer_comments_url.should == "/answers/666/comments"
    answer.question_id.should == 664
    answer.body.should be_nil

    user = answer.owner
    user.id.should == 58
    user.user_type.should == "registered"
    user.display_name.should == "cmcculloh"
    user.reputation.should == 2903
    user.email_hash.should == "298e0497aa6b76a573f17e6a2bb22dec"
  end
  
  it 'should include body when using :query => { :body => true }' do
    answer = StackOverflow::Answer.find(666, :query => { :body => true })
    answer.body.should == "<p>Absolutely not.</p>\r\n\r\n<p>Probably the best thing you could do though, might not be to actually program at all, but rather test test test. You can be great at testing because not only can you find all the little wacky problems, but you could pop open the code and find the areas causing the problems (possibly) and point them out even if you can't fix them. For instance:</p>\r\n\r\n<p>You find a bug, \"It looks like when I edit my own post, if it has up or down mods, I get those mod points added to my account again! Over and over even!\".</p>\r\n\r\n<p>So then you open the code and find the section that adds points and say, \"hrm... it looks like the logic here is broken. It's lines 589-633 in file \"modAdd.aspx\"... I'll submit a bug report with this info\".</p>\r\n\r\n<p>Now, if you got in over your head and started submitting all this bad code and brazenly demanding it get included, then you are <em>making</em> a hindrance of yourself. But it doesn't have to be that way.</p>\r\n\r\n<p>Another great thing you could do would be documentation. Telling users how to use the app in plain english. Or even work on the website for the project. Many open source projects need lots of help in these areas. Often you will go to a project's website, and have no idea what that project is even about, or how to even download it...</p>"
  end

  it 'should include comments associations' do
    answer = StackOverflow::Answer.find 555
    answer.comments.size.should_not == 1
    comment = answer.comments.first
    comment.id.should == 278816
  end

  it 'should find all answers associated to a user' do
    response = StackOverflow::Answer.find_by_user_id 1

    response.answers.size.should == 30
    response.total.should == 165
    first_answer = response.answers.first
    first_answer.answer_id.should == 1250987
  end

  it 'should find all answers associated to a question' do
    response = StackOverflow::Answer.find_by_question_id(549)
    response.answers.size.should == 20

    first_answer = response.answers.first
    first_answer.id.should == 2801312
    first_answer.accepted.should be_false
  end
end


