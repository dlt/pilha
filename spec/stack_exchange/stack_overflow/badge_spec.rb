require 'spec_helper'

describe StackExchange::StackOverflow::Badge do

  before do
    StackExchange::StackOverflow::Client.config
  end

  describe 'when querying for badges' do
    it 'should return badges' do
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
  end
end
