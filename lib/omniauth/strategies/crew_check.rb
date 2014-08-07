require 'omniauth-github'

module OmniAuth
  module Strategies
    class CrewCheck < OmniAuth::Strategies::GitHub
      option :role_map, {}

      extra do
        {
          :raw_info => raw_info,
          :teams => teams,
          :roles => roles
        }
      end

      protected
      def teams
        @teams ||= ::CrewCheck::TeamList.fetch(gh_token)
      end

      def roles
        @roles ||= ::CrewCheck::RoleDetermination.new(
          teams.shorthand_names,
          options.role_map).roles
      end

      def gh_token
        credentials['token']
      end
    end
  end
end

OmniAuth.config.add_camelization 'crew_check', 'CrewCheck'
