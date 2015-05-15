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
              'numFound' => @librarycloud_response[:pagination][:numFound],
              'start' => (@librarycloud_response[:pagination][:start] || 0),
              'docs' => @librarycloud_response[:items]
            },
            'facet_counts' => {
              'facet_fields' => solr_facets_from_librarycloud_facets
            }
          }
        end

        def solr_facets_from_librarycloud_facets
          response_facets = @librarycloud_response[:facets][:facetField] || []

          response_facets.each_with_object({}) do |facet, facets|
            facets[facet[:facetName]] = facet[:facet].collect do |field|
              [field[:term], field[:count]]
            end.flatten
          end
        end
      end
    end
  end
end
