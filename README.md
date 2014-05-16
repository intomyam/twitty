# Twitty

Twitty is simple ruby library for twitter bot creater.

## Twitty

Twitter bot (verified account) class.

## Twitty::tweeter

Twitter user (no verified account) class.

## Twitty::tweet

Tweet class.

## Examples

```ruby
MYBOT = Twitty.new do |config|
  config.consumer_key        = "YOUR_CONSUMER_KEY"
  config.consumer_secret     = "YOUR_CONSUMER_SECRET"
  config.access_token        = "YOUR_ACCESS_TOKEN"
  config.access_token_secret = "YOUR_ACCESS_SECRET"
end

recent_tweet = MYBOT.timeline.first
recent_tweet.reply "Hello #{recent_tweet.user.name}!"
```

*********

Copyright (c) 2014 silva(http://silva.vc/)

Released under the MIT license

http://opensource.org/licenses/mit-license.php