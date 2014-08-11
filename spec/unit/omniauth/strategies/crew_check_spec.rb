require 'spec_helper'
require "rack/test"
require 'omniauth/test'

describe OmniAuth::Strategies::CrewCheck, vcr: true do
  let(:parsed_response) { mock('Parsed Response') }
  let(:response) do
    mock('Response').tap do |m|
      m.stubs(:parsed).returns(parsed_response)
    end
  end

  let(:access_token) do
    mock.tap do |m|
      m.stubs(:options).returns({})
      m.stubs(:token).returns(ENV['GITHUB_TOKEN'])
      m.stubs(:expires?).returns(false)
      m.stubs(:get).returns(response)
    end
  end


  let(:mock_team_list) do
    mock('Team List').tap do |m|
      m.stubs(:shorthand_names).returns(['launchacademy/experience engineers'])
    end
  end

  let(:role_map) do
    {
      'admin' => ['launchacademy/experience engineers']
    }
  end

  let(:strategy) do
    OmniAuth::Strategies::CrewCheck.new('github key', 'github secret',
      :role_map => role_map).tap do |s|

      s.stubs(:teams).returns(mock_team_list)
      s.stubs(:access_token).returns(access_token)
    end
  end

  it 'provides a list of teams' do
    expect(strategy.extra[:teams]).to_not be_nil
  end

  it 'provides an unempty list of roles' do
    expect(strategy.extra[:roles]).to eq(['admin'])
  end


  context 'proc support' do
    let(:strategy) do
      the_proc = ->{{
        'admin' => mock_team_list.shorthand_names
      }}

      OmniAuth::Strategies::CrewCheck.new('github key', 'github secret', :role_map => the_proc).tap do |s|

        s.stubs(:teams).returns(mock_team_list)
        s.stubs(:access_token).returns(access_token)
      end
    end

    it 'allows a proc for the role map' do
      expect(strategy.extra[:roles]).to eq(['admin'])
    end
  end

  context 'requiring a role' do
    let(:role_map) do
      {
        'admin' => ['launchacademy/nerds']
      }
    end

    let(:mock_request) do
      Rack::Request.new(::Rack::MockRequest.env_for('/'))
    end

    let(:strategy) do
      OmniAuth::Strategies::CrewCheck.new('github key', 'github secret', {
        :role_map => role_map,
        :role_required => true,
        :provider_ignores_state => true
      }).tap do |s|

        s.stubs(:teams).returns(mock_team_list)
        s.stubs(:access_token).returns(access_token)
        s.stubs(:request).returns(mock_request)
        s.stubs(:env).returns({})
      end
    end

    it 'fails if a role is not found for the list of teams' do
      callback = strategy.callback_phase
      expect(callback[0]).to eql(302)
      expect(callback[1]['Location']).to include('invalid_credentials')
    end
  end
end
