# testing the response_rewriter/search
require 'minitest/autorun'
require 'minitest/pride'

require 'active_support/hash_with_indifferent_access'
require 'rsolr'
require 'rsolr/librarycloud'
require 'json'
require 'pry'

def r_symbolize_keys hsh
    case hsh
    when Hash
      hsh.reduce({}) do |r,(k,v)|
        r[k.to_sym] = r_symbolize_keys(v)
        r
      end
    when Array
      hsh.map {|el| r_symbolize_keys el}
    else
      hsh
    end
end

module ResponseRewriter
  class SearchTest < MiniTest::Test

    DATA_PATH = File.join(File.absolute_path('.').sub(/rsolr-librarycloud\/.*/, 'rsolr-librarycloud'),
                          "test", "data")

    @@libcloudRes = r_symbolize_keys(JSON.parse(File.read(File.join(DATA_PATH, 'exampleLibCloud.json'))))

    @@solrRes = r_symbolize_keys(JSON.parse(File.read(File.join(DATA_PATH, 'exampleLibCloud.json'))))

    def setup
      @search = RSolr::LibraryCloud::ResponseRewriter::Search.new(@@libcloudRes)
    end

    def test_translate_facets
      # Note: As of the time this test was written, LibraryCloud drops empty facets, whereas Solr,
      #       by default, does not.
      translated = @search.solr_facets_from_librarycloud_facets
      assert_equal(
        { "isOnline" =>
            [ false, 838,
              true,  260],
          "resourceType" =>
           [ "text",                        684,
             "still image",                 203,
             "sound recording-musical",     128,
             "moving image",                 31,
             "notated music",                11,
             "sound recording-nonmusical",    3,
                  "cartographic",             2,
                  "mixed material",           2,]
        },
        translated, "facet_fields differ from expected.")
    end
  end
end
