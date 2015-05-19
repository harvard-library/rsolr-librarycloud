# testing the request_rewriter/search
require 'minitest/autorun'
require 'active_support/hash_with_indifferent_access'
require 'rsolr'
require 'rsolr/librarycloud'

class Hash
  def wia
    return HashWithIndifferentAccess.new(self)
  end

end

class TestSearch < MiniTest::Test
  include TestHelpers

  def setup
    @inputHash = {'basic' => {q: 'peanuts'},'withwt' => {q: 'peanuts', wt: 'json'  },
      'withkw' => {q:"peanuts", name:"schulz" } }
    @outputHash = {'basic' => {q:"peanuts", start:0, limit:10},
      'withwt' => {q:"peanuts", start:0, limit:10},
      'withkw' => {q:"peanuts", name_keyword:"schulz", start:0, limit:10 } }
  end

  def test_path
    assert_equal(RSolr::LibraryCloud::RequestRewriter::Search.new(a: 1).path, '/api/v2/search.json', "Path should be /api/v2/search.json")
  end

  def test_basic
    assert_equal(RSolr::LibraryCloud::RequestRewriter::Search.new(@inputHash['basic']).execute, @outputHash['basic'].wia, "basic should be unchanged")
  end

  def test_with_wt
    assert_equal(RSolr::LibraryCloud::RequestRewriter::Search.new(@inputHash['withwt']).execute, @outputHash['withwt'].wia, "withwt should have wt stripped")
  end
  def test_with_kw
    assert_equal(RSolr::LibraryCloud::RequestRewriter::Search.new(@inputHash['withkw']).execute, @outputHash['withkw'].wia, "withkw should have name replaced with name_keyword")
  end
end
