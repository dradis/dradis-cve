module Dradis::Plugins::CVE
  
  # complete this with the different filters that your import plugin defines
  module Filters

    # Dummy filter that can be deleted
    class NVDKeyword < Dradis::Plugins::Import::Filters::Base
      CONF = {
        url: "https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&search_type=all&query="
      }

      def query(params={})
        results = []

        begin
          keyword = CGI::escape(params[:query])
          url = CONF[:url] + keyword
          html = Nokogiri::HTML(URI.open(url))

          table = html.at_xpath('//table[@data-testid="vuln-results-table"]')
          table.xpath('./tbody/tr').each do |tr|

            record = {}
            record[:id] = tr.at_xpath('./th').text()
            record[:summary] = tr.at_xpath('./td/p').text()
            record[:title] = "#{record[:id]}: #{record[:summary]}"
            record[:link] = "https://nvd.nist.gov/vuln/detail/#{record[:id]}"
            # record[:summary]   = dd.elements[0].text.split(': ')[1]
            # record[:published] = dd.elements[1].text.split(': ')[1]
            # record[:severity]  = dd.elements[2].text.split(': ')[1]
            # record[:vector]    = CGI::unescape(dd.elements[2].xpath('.//a').first['href'].split('&')[1].split('=')[1])
          
            results << Dradis::Plugins::Import::Result.new(
              title: record[:title],
              description: record.map{ |key,value| "#[#{key}]#\n#{value}" }.join("\n\n")
            )
          end
        rescue Exception => e
          results << Dradis::Plugins::Import::Result.new(
                      title: 'Error fetching records',
                      description: "#[Message]#\n#{e.message}\n\n\n" +
                                    "This error can be caused by a configuration " +
                                    "issue.\n\n" +
                                    "#[URL]#\n#{url}"
                    )
        end

        return results
      end
    end

  end  
end

Dradis::Plugins::Import::Filters.add :cve, :nvd_keyword, Dradis::Plugins::CVE::Filters::NVDKeyword
