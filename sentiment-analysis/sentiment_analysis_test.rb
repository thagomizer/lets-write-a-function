# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "minitest/autorun"
require "functions_framework/testing"

ENV['GOOGLE_CLOUD_KEYFILE'] = "/Users/ajahammerly/lets-write-a-function/lets-write-a-function.json"

class SentimentAnalysisTest < Minitest::Test
  include FunctionsFramework::Testing

  def test_success
    load_temporary "sentiment-analysis.rb" do
      request = make_post_request("https://example.com/foo",
                                  "{\"text\":\"I am happy\"}",
                                  ["Content-Type: application/json"])

      response = call_http "sentiment-analysis", request
      assert_equal 200, response.status
    end
  end
end
