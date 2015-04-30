module RSolr
  module LibraryCloud
    ##
    # LibraryCloud REST API client with RSolr interface
    class Client < RSolr::Client
      def initialize(connection, options = {})
        super(connection, options.merge(url: RSolr::LibraryCloud::URL))
      end

      def execute(request_context)
        RSolr::LibraryCloud.logger.debug(
          "LibraryCloud API request URL: #{request_context[:uri]}"
        )
        super
      end

      def build_request(path, opts)
        path, opts = adapt_request_for_api(path, opts)
        self.class.default_wt = 'json'
        super(path, opts)
      end

      def adapt_response(request, response)
        result = super
        if result[:object]
          rewriter = ResponseRewriter::Record.new(result)
        else
          rewriter = ResponseRewriter::Search.new(result)
        end
        rewriter.response
      end

      protected

      def adapt_request_for_api(_path, opts)
        if (opts[:params][:qt] == 'document') && opts[:params][:id]
          rewriter = RequestRewriter::Record.new(opts[:params])
        else
          rewriter = RequestRewriter::Search.new(opts[:params])
        end
        rewritten_params = rewriter.execute.merge(wskey: @options[:api_key])
        [rewriter.path, opts.merge(params: rewritten_params)]
      end
    end
  end
end
