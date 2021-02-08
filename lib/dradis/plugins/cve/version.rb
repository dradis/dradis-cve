require_relative 'gem_version'

module Dradis::Plugins::CVE
  # Returns the version of the currently loaded CVE as a
  # <tt>Gem::Version</tt>.
  def self.version
    gem_version
  end
end
