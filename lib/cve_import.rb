# CveImport

require 'cve_import/filters'
require 'cve_import/meta'

module CveImport
  class Configuration < Core::Configurator
    configure :namespace => 'cve_import'

    # setting :my_setting, :default => 'Something'
    # setting :another, :default => 'Something Else'
  end
end

# This includes the import plugin module in the dradis import plugin repository
module Plugins
  module Import
    include CveImport
  end
end
