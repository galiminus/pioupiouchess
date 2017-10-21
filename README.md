# Pioupiouchess

It's a chess game you can play on Twitter. You can start a game or join any game you can find and play against your followers in a tree of chess games.

Start a new game at https://pioupiouchess.phorque.it or play against me here https://twitter.com/ph0rqu3/status/921676233267646465

## Installation

```
bundle install
bundle exec rake db:create db:schema:load db:seed
```

## Configuration

In `config/application.yml`:

```
development:
  TWITTER_CLIENT_ID: XXX
  TWITTER_CLIENT_SECRET: XXX
  TWITTER_CONSUMER_KEY: XXX
  TWITTER_CONSUMER_SECRET: XXX
  DOMAIN: "localhost:3000"
  NO_TWITTER: "true"
```

The NO_TWITTER option is useful for testing: it will show you the next board instead of posting on Twitter.
