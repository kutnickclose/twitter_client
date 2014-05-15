require 'json'
require 'oauth'

module UsersHelper
  def save_user_tweets(user)
    
    consumer_key = OAuth::Consumer.new(
        ENV['TWITTER_CONSUMER_KEY'],
        ENV['TWITTER_CONSUMER_SECRET'])
    access_token = OAuth::Token.new(
       ENV['TWITTER_ACCESS_TOKEN'],
      ENV['TWITTER_ACCESS_TOKEN_SECRET'])

    baseurl = "https://api.twitter.com"
    path    = "/1.1/statuses/user_timeline.json"
    query   = URI.encode_www_form("screen_name" => user.screen_name.downcase)
    address = URI("#{baseurl}#{path}?#{query}")
    request = Net::HTTP::Get.new address.request_uri

    # Set up Net::HTTP to use SSL, which is required by Twitter.
    http = Net::HTTP.new(address.host, address.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Build the request and authorize it with OAuth.
    request = Net::HTTP::Get.new address.request_uri
    request.oauth!(http, consumer_key, access_token)

    # Issue the request and return the response.
    http.start
    response = http.request(request)

    JSON.parse(response.body).each do |tweet|
      tweet_to_save = Tweet.new
      tweet_to_save.text = tweet["text"]
      tweet_to_save.screen_name = tweet["user"]["screen_name"].downcase
      tweet_to_save.tweet_id = tweet["id"]
      tweet_to_save.tweet_created_at = tweet["created_at"]
      puts tweet["text"]
      puts tweet["screen_name"]
      puts tweet["id"]
      puts tweet["created_at"]
      puts tweet_to_save
      tweet_to_save.save
    end

  end
  
end
