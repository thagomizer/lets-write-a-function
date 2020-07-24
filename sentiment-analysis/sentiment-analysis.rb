require "functions_framework"
require "json"
require "google/cloud/language"


# This function receives an HTTP request of type Rack::Request
# and interprets the body as JSON. It prints the contents of
# the "message" field, or "Hello World!" if there isn't one.
FunctionsFramework.http "sentiment-analysis" do |request|
  language = Google::Cloud::Language.language_service

  body = JSON.parse request.body.read

  text = body["text"]

  document = { content: "Hello World" , type: :PLAIN_TEXT }

  response = language.analyze_sentiment(document: document)

  sentiment = response.document_sentiment
  "Score: #{sentiment.score}, #{sentiment.magnitude}"
end
