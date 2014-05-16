require 'json'
require './twitty/simple_o_auth'
require './twitty/tweet'
require './twitty/tweeter'

class Twitty
  attr_accessor :access_token, :access_token_secret, :consumer_key, :consumer_secret, :simple_oauth

  def initialize
    yield(self) if block_given?
    @simple_oauth = SimpleOAuth.new(consumer_key, consumer_secret, access_token, access_token_secret)

    Tweet.twitty = self
    Tweeter.twitty = self
  end

  def reply(tweet, tweet_id, query = {})
    Tweet.find(tweet_id).reply(tweet, query)
  end

  def public_reply
    Tweet.find(tweet_id).public_reply(tweet, query)
  end

  def twint(tweet, query = {})
    query[:in_reply_to_status_id] = query[:to] if query.has_key? :to

    @simple_oauth.post('https://api.twitter.com/1.1/statuses/update.json' + SimpleOAuth.query_to_s(query),  status: tweet)
  end

  def timeline(query = {})
    query[:count] = query[:limit] if query.has_key? :limit

    response = @simple_oauth.get('https://api.twitter.com/1.1/statuses/home_timeline.json' + SimpleOAuth.query_to_s(query))
    JSON.parse(response.body).collect do |status|
      Tweet.new(status)
    end
  end
end
