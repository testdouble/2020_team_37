require "./lib/bot"

bot = Bot.new(
  brain: Bot::DumbBrain.new,
  player: Bot::Player.new(
    name: "kj",
    food_stat: 5,
    water_stat: 5,
    stamina_stat: 5,
    strength_stat: 5
  )
)

bot.run
