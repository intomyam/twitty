class Twitty
  class Tweeter
    def initialize(content)
      @content = content
    end

    def self.twitty=(twitty)
      @@twitty = twitty
    end

    def self.find(id, query = {})
      query[:user_id] = id
      response = @@twitty.simple_oauth.get('https://api.twitter.com/1.1/users/show.json' + Twitty::SimpleOAuth.query_to_s(query))
      Twitty::Tweeter.new JSON.parse(response.body)
    end

    def self.find_by_name(name, query = {})
      query[:screen_name] = name
      response = @@twitty.simple_oauth.get('https://api.twitter.com/1.1/users/show.json' + Twitty::SimpleOAuth.query_to_s(query))
      Twitty::Tweeter.new JSON.parse(response.body)
    end

    def method_missing(method_name)
      name = method_name.to_s
      @content.has_key?(name) ? @content[name] : super
    end
  end
end
