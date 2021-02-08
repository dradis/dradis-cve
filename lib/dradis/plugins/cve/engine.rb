module Dradis::Plugins::CVE
  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::CVE

    include ::Dradis::Plugins::Base
    provides :import
    description 'Import entries from the CVE database'

    addon_settings :cve do
      settings.default_url    = 'http(s)'
    end

    initializer "cve.inflections" do |app|
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym('CVE')
      end
    end
  end
end
