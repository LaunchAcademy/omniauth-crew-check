require 'omniauth-github'

module OmniAuth
  module Strategies
    class CrewCheck < OmniAuth::Strategies::GitHub
      option :role_map, {}
      option :role_required, true

      extra do
        {
          :raw_info => raw_info,
          :teams => teams,
          :roles => roles
        }
      end

      def callback_phase
        if options.role_required && roles.empty?
          fail!(:invalid_credentials)
        else
          super
        end
      end

      protected
      def teams
        @teams ||= ::CrewCheck::TeamList.fetch(gh_token)
      end

      def roles
        ::CrewCheck::RoleDetermination.new(
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
