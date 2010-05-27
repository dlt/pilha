require 'spec_helper'

describe StackExchange::StackOverflow::Badge do

  before do
    StackExchange::StackOverflow::Client.config
  end

  describe 'when querying for badges' do
    it 'should return all badges' do
      response = StackOverflow::Badge.all
      first_badge = response.first
      first_badge.badge_id.should == 9
      first_badge.id.should == 9
      first_badge.rank.should == "bronze"
      first_badge.name.should == "Autobiographer"
      first_badge.description.should == "Completed all user profile fields"
      first_badge.award_count.should == 28065
      first_badge.tag_based.should be_false
      first_badge.badges_recipients_url.should == "/badges/9"
    end

    it 'should return all tag-based badges' do

      response = StackOverflow::Badge.all(:tag_based => true)
      first_tag_based = response.first
      first_tag_based.id.should == 204
      first_tag_based.rank.should == "silver"
      first_tag_based.name.should == ".htaccess"
      first_tag_based.description.should == "Earned 400 upvotes for answers in the .htaccess tag"
      first_tag_based.award_count.should == 1
      first_tag_based.tag_based.should be_true
      first_tag_based.badges_recipients_url.should == "/badges/204"

    end
  end
end
