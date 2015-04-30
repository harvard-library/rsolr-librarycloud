require 'rsolr'
require 'rsolr/librarycloud/version'
require 'logger'

module RSolr
  ##
  # Connects an RSolr consumer to the LibraryCloud REST API
  module LibraryCloud
    autoload :Client, 'rsolr/librarycloud/client'
    autoload :RequestRewriter, 'rsolr/librarycloud/request_rewriter'
    autoload :ResponseRewriter, 'rsolr/librarycloud/response_rewriter'

    # Base URL of the LibraryCloud REST API
    URL = 'http://www.librarycloud.eu/api/v2'

    # @return [RSolr::LibraryCloud::Client]
    def self.connect(*args)
      driver = args[0].is_a?(Class) ? args[0] : RSolr::Connection
      opts = args[-1].is_a?(Hash) ? args[-1] : {}
      RSolr::LibraryCloud::Client.new driver.new, opts
    end

    ##
    # Logger for the RSolr::LibraryCloud library
    #
    # Uses the Rails logger if available, otherwise STDOUT
    #
    # @return [ActiveSupport::Logger,Logger]
    def self.logger
      return @logger if @logger
      if defined?(Rails) && Rails.logger
        @logger = Rails.logger
      else
        @logger = Logger.new(STDOUT)
      end
      @logger
    end
  end
end
