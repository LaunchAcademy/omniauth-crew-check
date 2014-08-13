require 'crew_check/team'

require 'octokit'

module CrewCheck
  class TeamList
    include Enumerable

    def initialize(github_teams = [])
      @teams = github_teams.map do |gh_team|
        CrewCheck::Team.new(gh_team)
      end
    end

    def shorthand_names
      @teams.map do |team|
        team.shorthand_name
      end
    end

    class << self
      def fetch(token)
        with_octo_auto_pagination do
          client = Octokit::Client.new(access_token: token)
          new(client.user_teams)
        end
      end
    end

    def each(&block)
      @teams.each(&block)
    end

    def empty?
      @teams.size == 0
    end

    protected
    def self.with_octo_auto_pagination(&block)
      old_val = Octokit.auto_paginate
      Octokit.auto_paginate = true
      block.call.tap do
        Octokit.auto_paginate = old_val
      end
    end
  end
end
