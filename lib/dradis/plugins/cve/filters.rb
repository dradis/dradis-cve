require 'open-uri'

module CveImport
  
  # complete this with the different filters that your import plugin defines
  module Filters

    # Dummy filter that can be deleted
    module NVDKeyword
      NAME = "Keyword search against the NVD"
      CONF = {
        :url => "http://web.nvd.nist.gov/view/vuln/search-results?search_type=all&cves=on&query="
      }

      def self.run(params={})
        records = []

        begin
          keyword = CGI::escape(params[:query])
          url = CONF[:url] + keyword
          results = Nokogiri::HTML(open(url))

          elements = results.xpath('//dl/span').first.elements
          while(elements.any?)
            dt = elements.shift
            dd = elements.shift
            record = {}
            record[:title]     = "#{dt.text} (#{keyword})"
            record[:link]      = "http://web.nvd.nist.gov/view/vuln/detail?vulnId=" + dt.text
            record[:summary]   = dd.elements[0].text.split(': ')[1]
            record[:published] = dd.elements[1].text.split(': ')[1]
            record[:severity]  = dd.elements[2].text.split(': ')[1]
            record[:vector]    = CGI::unescape(dd.elements[2].xpath('.//a').first['href'].split('&')[1].split('=')[1])
          
            records << {
              :title => record[:title],
              :description => record.map{ |key,value| "#[#{key}]#\n#{value}" }.join("\n\n")
            }
          end
        rescue Exception => e
          records << { 
                      :title => 'Error fetching records',
                      :description => e.message + "\n\n\n" +
                                    "This error can be caused by a configuration " +
                                    "issue."
                     }
        end

        return records
      end
    end
 
    # Your filters go here. Feel free to rename
    module NVDCVE
    NAME = 'Search by CVE identifier'
      
      def self.run(params={})
        records = []
        # do stuff. For example
        records << { :title => 'This filter uses the config file', :description => "The value of 'some_property' is: #{CONF['some_property']}." }
        records << { :title => 'Filter information', :description => "Config file is located in #{CONF_FILE}" }
        return records
      end
    end
    
  end  
end
