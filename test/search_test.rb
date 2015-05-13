# testing the request_rewriter/search
require 'minitest/autorun'
require 'active_support/hash_with_indifferent_access'
require 'rsolr'
require 'rsolr/librarycloud'

class TestSearch < MiniTest::Test
  def setup
    @inputHash = {'basic' => {q: 'peanuts'},'withwt' => {q: 'peanuts', wt: 'json'  }}
    @outputHash = {'basic' => {"q"=>"peanuts", "start"=>1, "limit"=>10},
      'withwt' => {"q"=>"peanuts", "start"=>1, "limit"=>10}}
  end

  def test_path
    assert_equal(RSolr::LibraryCloud::RequestRewriter::Search.new(a: 1).path, '/api/v2/search.json', "Path should be /api/v2/search.json")
  end

  def test_basic
    assert_equal(RSolr::LibraryCloud::RequestRewriter::Search.new(@inputHash['basic']).execute, @outputHash['basic'], "basic should be unchanged")
  end

  def test_with_wt
    assert_equal(RSolr::LibraryCloud::RequestRewriter::Search.new(@inputHash['withwt']).execute, @outputHash['basic'], "withwt should have wt stripped")
  end

end
