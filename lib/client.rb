require 'json'

module Client
  TEAM_ID = 37
  API_URL = 'http://retreat-game.herokuapp.com/api/'

  class << self
    def show_player
      command "curl --silent -H 'team: #{TEAM_ID}' #{API_URL}/player"
    end

    def create_player(args)
      name           = args[:name]
      water_stat     = args[:water_stat]
      food_stat      = args[:food_stat]
      stamina_stat   = args[:stamina_stat]
      strength_stat  = args[:strength_stat]

      data = [
        "player[name]=#{name}",
        "player[water_stat]=#{water_stat}",
        "player[food_stat]=#{food_stat}",
        "player[stamina_stat]=#{stamina_stat}",
        "player[strength_stat]=#{strength_stat}"
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
      JSON.parse(response).tap do |json|
        raise json["error"] if json["error"]
      end
    end

    def wait
      sleep 0.2
    end
  end
end
