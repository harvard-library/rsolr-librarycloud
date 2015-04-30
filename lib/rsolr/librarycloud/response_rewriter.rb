module RSolr
  module LibraryCloud
    ##
    # Container module for response rewriters
    module ResponseRewriter
      autoload :Base, 'rsolr/librarycloud/response_rewriter/base'
      autoload :Record, 'rsolr/librarycloud/response_rewriter/record'
      autoload :Search, 'rsolr/librarycloud/response_rewriter/search'
    end
  end
end
