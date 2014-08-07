require 'spec_helper'
require "rack/test"
require 'omniauth/test'

describe OmniAuth::Strategies::CrewCheck, vcr: true do
  let(:parsed_response) { mock('Parsed Response') }
  let(:response) { mock('Response', :parsed => parsed_response) }

  let(:access_token) do
    mock.tap do |m|
      m.stubs(:options).returns({})
      m.stubs(:token).returns(ENV['GITHUB_TOKEN'])
      m.stubs(:expires?).returns(false)
      m.stubs(:get).returns(response)
    end
  end


  let(:mock_team_list) do
    mock('Team List', :shorthand_names => ['launchacademy/experience engineers'])
  end

  let(:strategy) do
    OmniAuth::Strategies::CrewCheck.new('github key', 'github secret', {
      :role_map => {
        'admin' => ['launchacademy/experience engineers']
      }
    }).tap do |s|
      s.stubs(:teams).returns(mock_team_list)
    end
  end

  before(:each) do
    strategy.stubs(:access_token).returns(access_token)
  end

  it 'provides a list of teams' do
    expect(strategy.extra[:teams]).to_not be_nil
  end

  it 'provides an unempty list of roles' do
    expect(strategy.extra[:roles]).to eq(['admin'])
  end
end
