module CveImport  
  module Meta
    NAME = "Search CVE records of the National Vulnerability Database"
    # change this to the appropriate version
    module VERSION #:nodoc:
      MAJOR = 2
      MINOR = 10
      TINY = 0

      STRING = [MAJOR, MINOR, TINY].join('.')
    end
  end
end
