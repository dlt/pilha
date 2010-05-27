require 'spec_helper'

describe StackExchange::StackOverflow::User do 

    it "should the users that have been awarded the badge identified by 'id'" do
      response = StackOverflow::User.find_by_badge_id 9
      response.total.should == 28080
      response.page.should == 1
      response.pagesize.should == 30

      first_user = response.users.first
      first_user.should be_instance_of StackOverflow::User
      first_user.user_id.should == 349130
      first_user.user_type.should == "registered"
      first_user.creation_date.should == 1274719205
      first_user.display_name.should == "matias.valdenegro"
      first_user.reputation.should == 16
      first_user.email_hash.should == "2e4efeebbf6994bb904738c4fb8922bf"
      first_user.age.should == 25
      first_user.last_access_date.should == 1274894693
      first_user.website_url.should == "http://None"
      first_user.location.should == "Santiago, Chile."
      first_user.about_me.should == "Computer Engineer, interested in Robotics, Computer Graphics, and GPGPU."
      first_user.question_count.should be_zero
      first_user.answer_count.should == 2
      first_user.view_count.should be_zero
      first_user.up_vote_count.should be_zero
      first_user.down_vote_count.should be_zero
      first_user.user_questions_url.should == "/users/349130/questions"
      first_user.user_answers_url.should == "/users/349130/answers"
      first_user.user_tags_url.should == "/users/349130/tags"
      first_user.user_badges_url.should == "/users/349130/badges"
      first_user.user_timeline_url.should == "/users/349130/timeline"
      first_user.user_mentioned_url.should == "/users/349130/mentioned"
      first_user.user_comments_url.should == "/users/349130/comments"
      first_user.user_reputation_url.should == "/users/349130/reputation"
      first_user.badge_counts['gold'].should be_zero
      first_user.badge_counts['silver'].should be_zero
      first_user.badge_counts['bronze'].should == 1
    end

    it 'should return the right number of items when pagesize is passed in the query parameters' do
      response = StackOverflow::User.find_by_badge_id(9, :pagesize => 50)
      response.pagesize.should == 50
      response.users.size.should == 50
    end
end
