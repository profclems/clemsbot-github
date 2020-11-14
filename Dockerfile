FROM docker.pkg.github.com/coq/bot/coqbot:v0.2.0

COPY bot_config.toml ./

#EXPOSE 8000 # The port you specified in bot_config.toml
            # (this command is ignored if you deploy to Heroku)

CMD ["./bot.exe", "bot_config.toml"]
