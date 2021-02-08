class DradisTasks < Thor
  class Import < Thor
    namespace "dradis:import:cve"

   desc "keyword QUERY", "import CVE records from the NVD"
   long_desc "This command searches CVE records from the National Vulnerability Database (http://web.nvd.nist.gov/)"
   def keyword(query)
     require 'config/environment'

     results = Dradis::Plugins::CVE::Filters::NVDKeyword.run(query: query)

     puts "CVE Search\n==========="
     puts "#{results.size} results"

     results.each do |record|
       puts "#{record[:title]}\n\t#{record[:description]}"
     end
   end
  end
end
