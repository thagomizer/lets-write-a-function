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

require "functions_framework"
require "json"
require "google/cloud/language"

# This function receives an HTTP request of type Rack::Request
# and interprets the body as JSON. It prints the contents of
# the "message" field, or "Hello World!" if there isn't one.
FunctionsFramework.http "sentiment_analysis" do |request|
  language = Google::Cloud::Language.language_service

  body = JSON.parse request.body.read

  text = body["text"]

  document = { content: "Hello World" , type: :PLAIN_TEXT }

  response = language.analyze_sentiment(document: document)

  sentiment = response.document_sentiment
  "Score: #{sentiment.score}, #{sentiment.magnitude}"
end
