class TwitterNotifier
  def self.push(game)
    client = build_client(game.user)
    body = build_message_body_for(game)

    if body.length < 140
      thumbnail_path = thumbnail_for(game)
      begin
        client.update_with_media(body, File.open(thumbnail_path), in_reply_to_status_id: game.try(:parent).tweet_reference)
      ensure
        File.unlink(thumbnail_path)
      end
    else
      Rails.logger.debug body
    end
  end

  def self.build_client(user)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
  end

  def self.build_message_body_for(game)
    message =
      if game.try(:parent).try(:user).try(:nickname).present?
        [ "@#{game.parent.user.nickname}" ]
      else
        []
      end

    message << game.move

    if game.chess_game.over?
      message << GamesHelper::game_status(game)
    else
      message << "Play the next move on #{Rails.application.routes.url_helpers.short_new_game_url(parent_id: game.id, host: ENV['DOMAIN'])}"
    end

    message.join(" ")
  end

  def self.thumbnail_for(game)
    File.join(Dir::Tmpname.tmpdir, Dir::Tmpname.make_tmpname("", "chess")).tap do |tmpfile|
      image = Chess2PNG.new.encode(game.chess_game.current)
      image.save(tmpfile)
    end
  end

end
