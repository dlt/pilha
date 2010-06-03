require 'spec_helper'

describe StackExchange::StackOverflow::Statistics do

  describe 'when querying for statistics' do
    it "should return the stack overflow's statistics" do
      response = StackOverflow::Statistics.all
      response.total_questions.should == 692539
      response.total_unanswered.should == 107245
      response.total_answers.should == 1938135
      response.total_comments.should == 2724322
      response.total_votes.should == 6817279
      response.total_badges.should == 699700
      response.total_users.should == 247683
      response.questions_per_minute.should == 1.78
      response.answers_per_minute.should == 3.71
      response.badges_per_minute.should == 1.58
      response.api_version['version'].should == "0.8"
      response.api_version['revision'].should == "1.0.1234.5678"
    end
  end

end
