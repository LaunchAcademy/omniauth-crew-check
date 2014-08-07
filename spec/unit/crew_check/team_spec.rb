require 'spec_helper'

describe CrewCheck::Team do
  let(:github_team) do
    {
      :name=>"team blue",
      :id=>123123123123123,
      :slug=>"team-blue",
      :permission=>"admin",
      :url=>"https://api.github.com/teams/123123123123123",
      :members_url=>"https://api.github.com/teams/123123123123123/members{/member}",
      :repositories_url=>"https://api.github.com/teams/123123123123123/repos",
      :members_count=>11,
      :repos_count=>190,
      :organization=> {
        :login=>"LaunchAcademy",
        :id=>3612691,
        :url=>"https://api.github.com/orgs/LaunchAcademy",
        :repos_url=>"https://api.github.com/orgs/LaunchAcademy/repos",
        :events_url=>"https://api.github.com/orgs/LaunchAcademy/events",
        :members_url=>"https://api.github.com/orgs/LaunchAcademy/members{/member}",
        :public_members_url=>
        "https://api.github.com/orgs/LaunchAcademy/public_members{/member}",
        :avatar_url=>"https://avatars.githubusercontent.com/u/3612691?v=2",
        :name=>"Launch Academy",
        :company=>nil,
        :blog=>"http://launchacademy.com",
        :location=>"Boston, MA",
        :email=>"hello@launchacademy.com",
        :public_repos=>89,
        :public_gists=>0,
        :followers=>0,
        :following=>0,
        :html_url=>"https://github.com/LaunchAcademy",
        :created_at=> Time.parse("2013-02-16 18:16:02 UTC"),
        :updated_at=> Time.parse("2014-08-07 18:35:21 UTC"),
        :type=>"Organization"
      }
    }
  end

  let(:team) do
    CrewCheck::Team.new(github_team)
  end

  it 'has a shorthand name' do
    expect(team.shorthand_name).to_not be_nil
  end

  it 'has a shorthand name that includes the organization login' do
    expect(team.shorthand_name).to include(github_team[:organization][:login].downcase)
  end

  it 'has a shorthand nmae that includes the team name' do
    expect(team.shorthand_name).to include(github_team[:name].downcase)
  end
end
