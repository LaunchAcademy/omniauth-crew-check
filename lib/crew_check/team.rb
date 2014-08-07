module CrewCheck
  class Team
    def initialize(github_team = nil)
      @github_team = github_team
    end

    def shorthand_name
      "#{organization_name}/#{name}"
    end

    protected
    def name
      if @github_team[:name]
        @github_team[:name].downcase
      end
    end

    def organization_name
      if @github_team[:organization] && @github_team[:organization][:login]
        @github_team[:organization][:login].downcase
      end
    end
  end
end
