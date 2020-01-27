require 'json'
require 'mother'

module Client
  TEAM_ID = 37
  API_URL = 'http://retreat-game.herokuapp.com/api/'

  class << self
    def show_player
      command "curl --silent -H 'team: #{TEAM_ID}' #{API_URL}/player"
    end

    def create_player(player)
      data = [
        "player[name]=#{player.name}",
        "player[water_stat]=#{player.water_stat}",
        "player[food_stat]=#{player.food_stat}",
        "player[stamina_stat]=#{player.stamina_stat}",
        "player[strength_stat]=#{player.strength_stat}"
      ].join('&')
      command "curl --silent -H 'team: #{TEAM_ID}' -d '#{data}' #{API_URL}/players"
    end

    def move(direction)
      possible_moves = %w[ NORTH EAST SOUTH WEST ]
      raise "Invalid direction!" unless possible_moves.include?(direction)
      command "curl --silent -H 'team: #{TEAM_ID}' -d 'direction=#{direction}' #{API_URL}/moves"
    end

    private

    def command(url)
      wait

      response = `#{url}`
      Mother.create(JSON.parse(response)).tap do |json|
        raise json.error if json.error
      end
    end

    def wait
      sleep 0.2
    end
  end
end
