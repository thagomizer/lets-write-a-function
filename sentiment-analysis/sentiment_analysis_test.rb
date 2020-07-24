require "minitest/autorun"
require "functions_framework/testing"

class SentimentAnalysisTest < Minitest::Test
  include FunctionsFramework::Testing

  def test_success
    load_temporary "sentiment-analysis.rb" do
      request = make_post_request "https://example.com/foo", "{\"text\":\"I am happy\"}",
                                  ["Content-Type: application/json"]
      response = call_http "sentiment-analysis", request
      assert_equal 200, response.status
    end
  end
end
