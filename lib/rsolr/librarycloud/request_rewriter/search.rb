module RSolr
  module LibraryCloud
    module RequestRewriter
      ##
      # Search request rewriter
      #
      # I MESSED UP!!  I have to do more research on the fieldname stuff...
      #  replace q=[value]with q=keyword:[value]
      # replace  q=[fieldname]:[value] with q=[fieldName]_keyword:[value]
      # if any facets:
      #   add facet:true
      #   break out  single string of facetNames (comma delimited) into facet.field={facetName}


#irb --> arr
#    ==> ["foo", "bar", "mumble", "fratz"]
#
#irb --> x
#    ==> "bar"
#
#irb --> y = "bat"
#    ==> "bat"
#
#irb --> arr.include? y
#    ==> false
#
#irb --> arr.include? x
#    ==> true
#
#irb -->

      class Search < Base
        NOT_KEYWORDED = %w(callback sort start limit row q facet facet.field wt sort.asc sort.desc)
        @rewrite_methods = [:delete_search_params, :rewrite_search_params,
                            :delete_params, :rewrite_solr_local_params]
        def path
          '/api/v2/search.json'
        end

        def rewrite_search_params
          # I'm sure there's a more elegant way to do this
          @tempParams = HashWithIndifferentAccess.new
          @params.each do |k, v|
            if !NOT_KEYWORDED.include? k
              @tempParams[k +'_keyword'] = @params.delete(k)
            end
          end
          @tempParams.each do |k, v|
            @params[k] = v
          end
          if @params.delete(:facet)
            @params[:facetNames] = @params.delete("facet.field").join(",")
          end
          # library cloud starts at 0, as does solr
          @params[:start] = (@params[:start] || 0) 
          @params[:limit] = (@params.delete('rows') || 10)
#TODO: DEALING WITH QF
#          @params[:qf] = @params.delete(:fq) unless @params[:fq].blank?
#          @params[:qf] = (@params[:qf] || []) + (@params.delete(:fq) || [])
        end

        ##
        # Removes params unsupported by the API
        #
        # @todo implement in the API / map to s'thing else / raise error if
        #   present
        def delete_search_params
          #TODO: we're going the other way, maybe
          %w(facet.pivot facet.query sort spellcheck.q).each do |k|
            @params.delete(k)
          end
        end
      end
    end
  end
end
