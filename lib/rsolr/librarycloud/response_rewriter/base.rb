module RSolr
  module LibraryCloud
    module ResponseRewriter
      ##
      # Base class for response rewriters
      class Base
        def initialize(librarycloud_response)
          @librarycloud_response = librarycloud_response
        end

        def response
          rewrite_response if @response.nil?
          @response
        end

        def rewrite_response
          fail NotImplementedError
        end
      end
    end
  end
end
