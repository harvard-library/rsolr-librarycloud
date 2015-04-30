module RSolr
  module LibraryCloud
    module ResponseRewriter
      ##
      # Search response rewriter
      class Search < Base
        ##
        # Adapts a response from the API's Search method to resemble a Solr
        # query response.
        def rewrite_response
          @response = {
            'response' => {
              'numFound' => @librarycloud_response[:totalResults],
              'start' => (@librarycloud_response[:params][:start] || 0) - 1,
              'docs' => @librarycloud_response[:items]
            },
            'facet_counts' => {
              'facet_fields' => solr_facets_from_librarycloud_facets
            }
          }
        end

        def solr_facets_from_librarycloud_facets
          response_facets = @librarycloud_response[:facets] || []
          response_facets.each_with_object({}) do |facet, facets|
            facets[facet[:name]] = facet[:fields].collect do |field|
              [field[:label], field[:count]]
            end.flatten
          end
        end
      end
    end
  end
end
