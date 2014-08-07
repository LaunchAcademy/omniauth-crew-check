require 'spec_helper'

describe CrewCheck::TeamList, vcr: true do
  let(:github_token) { ENV['GITHUB_TOKEN'] }

  it 'fetches a list of teams' do
    list = CrewCheck::TeamList.fetch(github_token)
    expect(list).to_not be_empty
  end
end
