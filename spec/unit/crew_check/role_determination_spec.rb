require 'spec_helper'

describe CrewCheck::RoleDetermination do
  let(:admin_teams) do
    [
      'launchacademy/experience engineers'
    ]
  end

  let(:guest_lecturer_team) do
    'launchacademy/guest lecturer'
  end

  let(:role_map) do
    {
      'admin' => admin_teams,
      'users' => ['launchacademy/students'],
      'educator' => [guest_lecturer_team]
    }
  end

  let(:role_determination) do
    CrewCheck::RoleDetermination.new(admin_teams, role_map)
  end

  it 'calculates the list of effective roles' do
    expect(role_determination.roles).to eq(['admin'])
  end

  it 'allows for multiple roles' do
    admin_teams << guest_lecturer_team
    expect(role_determination.roles).to eq(['admin', 'educator'])
  end

  it 'returns an empty set if a team is not found' do
    other_teams = ['launchacademy/something crazy']
    role_determination = CrewCheck::RoleDetermination.new(other_teams, role_map)
    expect(role_determination.roles).to eq([])
  end
end
