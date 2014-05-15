require 'json'
require 'oauth'
require 'addressable/uri'

# Change the following values to those provided on dev.twitter.com
# The consumer key identifies the application making the request.
# The access token identifies the user making the request.
consumer_key = OAuth::Consumer.new(
    "1E5kEGlW6Hw69Cj2LZwWUUxXD",
    "byTxVD3WBhFXnrgs7DWOtTZ7moHCZEnPrM2RH3WBXHOxeRgHiH")
access_token = OAuth::Token.new(
    "40560241-s0Y8X146D1hf0t2DRBzWLTxcyyzJ7mySqpAQ0MstH",
    "4q3pLRpQqzszPAKR8S2smsJnoXVbUEMhHGpfeunxAvM4T")

baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/user_timeline.json"
query   = URI.encode_www_form("screen_name" => "timkutnick")
address = URI("#{baseurl}#{path}?#{query}")
request = Net::HTTP::Get.new address.request_uri

puts address.request_uri

# Set up Net::HTTP to use SSL, which is required by Twitter.
http = Net::HTTP.new address.host, address.port
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Build the request and authorize it with OAuth.
request = Net::HTTP::Get.new address.request_uri
request.oauth!(http, consumer_key, access_token)

# Issue the request and return the response.
http.start
response = http.request(request)
i = 0
JSON.parse(response.body).each do |tweet|
  puts i.to_s + tweet["text"]
  i +=1
end
