class Api::V1::TwitterApiController < ApplicationController
  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["twitter_consumer_key"]
    config.consumer_secret = ENV["twitter_consumer_secret"]
    config.access_token = ENV["twitter_access_token"]
    config.access_token_secret = ENV["twitter_access_token_secret"]
  end

 def get_tweet_text(twitter_handle) # e.g. 'realDonaldTrump'
   tweets = []

   begin
     twitter_result = @@client.user_timeline(twitter_handle, options = {count: 200})
     twitter_result.each do |tweet|
       tweets << tweet.text
     end
   rescue Twitter::Error
   end

   tweets.join(" ")
 end
end
