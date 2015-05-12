module RSolr
  module LibraryCloud
    module RequestRewriter
      ##
      # Search request rewriter
      #  replace q=keyword:[value] with q=[value]
      # replace q=[keywordName]_keyword:[value] with q=[keywordName]:[value]
      # if any facets:
      #   remove facet:true
      #   collect facetNames in a single string, comma delimited.

      class Search < Base
        @rewrite_methods = [:delete_search_params, :rewrite_search_params,
                            :delete_params, :rewrite_solr_local_params]

        def path
          '/api/v2/search.json'
        end

        def rewrite_search_params
          @params[:query] = @params.delete(:q)
          @params[:query] = '*:*' if @params[:query] == '{!qf=all_fields}'
          @params[:profile] = 'facets params'
          @params[:facet] = @params.delete('facet.field')
          @params[:start] = (@params[:start] || 0) + 1
          @params[:limit] = @params.delete('rows')
#          @params[:qf] = @params.delete(:fq) unless @params[:fq].blank?
          @params[:qf] = (@params[:qf] || []) + (@params.delete(:fq) || [])
        end

        ##
        # Removes params unsupported by the API
        #
        # @todo implement in the API / map to s'thing else / raise error if
        #   present
        def delete_search_params
          %w(facet facet.pivot facet.query sort spellcheck.q).each do |k|
            @params.delete(k)
          end
        end
      end
    end
  end
end
