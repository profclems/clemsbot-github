FROM docker.pkg.github.com/coq/bot/coqbot:latest

COPY bot_config.toml ./

EXPOSE 8000 # The port you specified in bot_config.toml
            # (this command is ignored if you deploy to Heroku)

CMD ["./bot.exe", "bot_config.toml"]
