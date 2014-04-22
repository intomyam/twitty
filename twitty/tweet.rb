class Twitty::Tweet
  def initialize(content)
    @content = content
  end

  def self.twitty=(twitty)
    @@twitty = twitty
  end

  def self.find(id, query = {})
    query[:id] = id
    response = @@twitty.simple_oauth.get('https://api.twitter.com/1.1/statuses/show.json' + Twitty::SimpleOAuth.query_to_s(query))
    Twitty::Tweet.new JSON.parse(response.body)
  end

  def user
    Twitty::Tweeter.find(@content['user']['id'])
  end

  def reply(tweet, query = {})
    query[:in_reply_to_status_id] = id
    @@twitty.twint("@#{user.screen_name} " + tweet, query)
  end

  def public_reply(tweet, query = {})
    query[:in_reply_to_status_id] = id
    @@twitty.twint(tweet, query)
  end

  def method_missing(method_name)
    name = method_name.to_s
    @content.has_key?(name) ? @content[name] : super
  end
end
