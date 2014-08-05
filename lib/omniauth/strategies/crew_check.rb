require 'omniauth-github'

module OmniAuth
  module Strategies
    class CrewCheck < OmniAuth::Strategies::GitHub
      extra do
        {
          :raw_info => raw_info
        }
      end
    end
  end
end

OmniAuth.config.add_camelization 'crew_check', 'CrewCheck'
