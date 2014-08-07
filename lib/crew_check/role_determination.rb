module CrewCheck
  class RoleDetermination
    def initialize(team_list, role_map)
      @team_list = team_list
      @role_map = role_map
    end

    def roles
      unless @roles
        @roles = []
        @role_map.each do |role, team_list|
          @roles << role.downcase if !(team_list & @team_list).empty?
        end
      end

      @roles
    end
  end
end
