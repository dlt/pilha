require 'spec_helper'

describe StackExchange::StackOverflow::Question do

  it 'should return a question identified by its id (without body)' do
    question = StackOverflow::Question.find 1234
    question.id.should == 1234
    question.answer_count.should == 6
    question.tags.should == ['csla']
    question.creation_date.should == 1217857235
    question.last_activity_date.should == 1236665990
    question.up_vote_count.should == 2
    question.down_vote_count.should be_zero
    question.view_count.should == 1081
    question.score.should == 2
    question.community_owned.should be_false
    question.accepted_answer_id.should == 1239
    question.favorite_count.should == 1
    question.question_timeline_url.should == "/questions/1234/timeline"
    question.question_comments_url.should == "/questions/1234/comments"
    question.question_answers_url.should == "/questions/1234/answers"

    question.owner.id.should == 296
    question.owner.user_type.should == "registered"
    question.owner.display_name.should == "jdecuyper"
    question.owner.reputation.should == 1189
    question.owner.email_hash.should == "21ae3e5f2968bc957b7a6fa709bea2a0"

    question.answers.should be_instance_of Array
    question.answers.size.should == 6
    question.title.should == "CSLA Master Class"
    question.body.should be_nil
  end

  it 'should include body when using :query => { :body => true }' do
    question = StackOverflow::Question.find 1234, :query => { :body => true }
    question.body.should == "<p>Hi guys!\r\nAs anyone ever assisted the CSLA Master Class from Rockford Lhotka? (<a href=\"http://www.dunntraining.com/training/cslamasterclass.htm\" rel=\"nofollow\">www</a>).\r\n<br><br>\r\nIt seems a good way to enforce my OO knowledge in the asp.net field, but since I have to consider the flight to Atlanta and the course's price ($ 2.500), I'm not convinced yet. <br>\r\n<br>\r\nAlso, I could barrely find any feedback on the web.<br><br>\r\nCould anyone share some experience or comments?<br><br>\r\nThanks a lot. </p>"
  end

  it 'should find a question identified by its user_id' do 
    response = StackOverflow::Question.find_by_user_id 333
    response.page.should == 1
    response.pagesize.should == 30
    question = response.questions.first
    question.tags.should == ['c++', 'gcc']
    question.answer_count.should == 3
    question.accepted_answer_id.should == 267415
    question.favorite_count.should == 1
    question.question_timeline_url.should == "/questions/267248/timeline"
    question.question_comments_url.should == "/questions/267248/comments"
    question.question_answers_url.should == "/questions/267248/answers"
    question.id.should == 267248
    question.creation_date.should == 1225930514
    question.last_activity_date.should  == 1225938787
    question.up_vote_count.should == 2
    question.down_vote_count.should be_zero
    question.view_count.should == 266
    question.score.should == 2
    question.community_owned.should be_false
    question.title.should == "Getting rid of gcc shift by negative warning"
    question.owner.id.should == 333
  end

  it 'should find questions favorite to a user identified by id' do
    response = StackOverflow::Question.find_favorites_by_user_id 549
    response.total.should == 17
    response.page.should == 1
    response.pagesize.should == 30

    questions = response.questions

    question = response.questions.first

    question.tags.should == ['nhibernate']
    question.answer_count.should == 7
    question.question_timeline_url.should == "/questions/451664/timeline"
    question.question_comments_url.should == "/questions/451664/comments"
    question.question_answers_url.should == "/questions/451664/answers"
    question.id.should == 451664

    owner = question.owner
    owner.id.should == 52390
    owner.user_type.should == "registered"
    owner.display_name.should == "Przemek"
    owner.reputation.should == 360
    owner.email_hash.should == "46ee3f5f203756778eb8af634bbbfb7e"

    question.creation_date.should == 1232134747
    question.last_activity_date.should == 1274935956
    question.up_vote_count.should == 2
    question.down_vote_count.should be_zero
    question.view_count.should == 886
    question.score.should == 2
    question.community_owned.should be_false
    question.title.should == "Is there any NHibernate book?"
  end



  it 'should get questions by tag' do
    response = StackOverflow::Question.find_by_tags('ruby')
    response.total.should == 10153

    questions = response.questions
    questions.each do |question|
      question.tags.should include 'ruby'
    end
  end

  it 'should get questions containing multiple tags' do
    response = StackOverflow::Question.find_by_tags('gwt', 'google-app-engine')

    questions = response.questions
    questions.each do |question|
      question.tags.should include 'gwt'
      question.tags.should include 'google-app-engine'
    end
  end

  it 'should get unanswered questions' do
    response = StackOverflow::Question.unanswered
    response.total.should == 110617
    response.questions.size.should == response.pagesize

    response.questions.first.id.should == 2965530
    response.questions.first.tags.should == ['javascript', 'twitter', 'twitterapi']
  end
end
