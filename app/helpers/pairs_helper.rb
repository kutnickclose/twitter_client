module PairsHelper
  
  def save_common_followings(pair)
    consumer_key = OAuth::Consumer.new(
        ENV['TWITTER_CONSUMER_KEY'],
        ENV['TWITTER_CONSUMER_SECRET'])
    access_token = OAuth::Token.new(
       ENV['TWITTER_ACCESS_TOKEN'],
      ENV['TWITTER_ACCESS_TOKEN_SECRET'])
      
      
    #first request 
    baseurl = "https://api.twitter.com"
    path    = "/1.1/friends/list.json"
    query   = URI.encode_www_form("screen_name" => pair.first_screen_name, "count" => "200")
    address = URI("#{baseurl}#{path}?#{query}")

    # Set up Net::HTTP to use SSL, which is required by Twitter.
    http = Net::HTTP.new(address.host, address.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Build the request and authorize it with OAuth.
    request = Net::HTTP::Get.new address.request_uri
    request.oauth!(http, consumer_key, access_token)

    # Issue the request and return the response.
    http.start
    response1 = http.request(request)
    
    #second request
    query   = URI.encode_www_form("screen_name" => pair.second_screen_name, "count" => "200")
    address = URI("#{baseurl}#{path}?#{query}")
    request = Net::HTTP::Get.new address.request_uri
    request.oauth!(http, consumer_key, access_token)
    response2 = http.request(request)
    
    #store all id's of first followings into hash
    first_ids = {}
    following_data1 = JSON.parse(response1.body)
    following_data1["users"].each do |following|
      first_ids[following["id"]] = true 
    end
    
    
    #if id of second followings is in first_ids hash, save it
    following_data2 = JSON.parse(response2.body)
    following_data2["users"].each do |following|
      if first_ids[following["id"]]
        following_to_save = CommonPairFollowing.new
        following_to_save.pair_id = pair.id
        following_to_save.screen_name = following["screen_name"]
        following_to_save.following_id = following["id"].to_i
        following_to_save.save
      end
    end
  end
end
