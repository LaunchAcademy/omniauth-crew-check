require 'omniauth-github'

module OmniAuth
  module Strategies
    class CrewCheck < OmniAuth::Strategies::GitHub
      extra do
        {
          :raw_info => raw_info,
          :teams => teams,
          :crew_check_roles => roles
        }
      end

      protected
      def teams
        @teams ||= ::CrewCheck::TeamList.fetch(gh_token)
      end

      def roles
        []
      end

      def gh_token
        credentials['token']
      end
    end
  end
end

OmniAuth.config.add_camelization 'crew_check', 'CrewCheck'
