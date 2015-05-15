# testing the response_rewriter/search
require 'minitest/autorun'
require 'minitest/pride'

require 'active_support/hash_with_indifferent_access'
require 'rsolr'
require 'rsolr/librarycloud'
require 'json'
require 'pry'

module ResponseRewriter
  class SearchTest < MiniTest::Test
    DATA_PATH = File.join(File.absolute_path('.').sub(/rsolr-librarycloud\/.*/, 'rsolr-librarycloud'),
                          "test", "data")

    @@libcloudRes = JSON.parse(File.read(File.join(DATA_PATH, 'exampleLibCloud.json')))
    @@solrRes = JSON.parse(File.read(File.join(DATA_PATH, 'exampleLibCloud.json')))

    def setup
      @search = RSolr::LibraryCloud::ResponseRewriter::Search.new(@@libcloudRes)
    end

    def test_translate_facets
      # test go here
    end
  end
end
