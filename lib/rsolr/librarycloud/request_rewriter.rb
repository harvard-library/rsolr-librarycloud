module RSolr
  module LibraryCloud
    ##
    # Container module for request rewriters
    module RequestRewriter
      autoload :Base, 'rsolr/librarycloud/request_rewriter/base'
      autoload :Record, 'rsolr/librarycloud/request_rewriter/record'
      autoload :Search, 'rsolr/librarycloud/request_rewriter/search'
    end
  end
end
