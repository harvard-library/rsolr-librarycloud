# testing the request_rewriter/search
require 'minitest/autorun'
require 'active_support/hash_with_indifferent_access'
require 'rsolr'
require 'rsolr/librarycloud'

class TestSearch < MiniTest::Test
  def setup
    @inputHash = {'basic' =>'q=peanuts'}
  end

  def test_path
    assert_equal(RSolr::LibraryCloud::RequestRewriter::Search.new(a: 1).path, '/api/v2/search.json')
  end

end
