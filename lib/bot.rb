require_relative "./client"

class Bot
  def initialize(brain:, player:)
    @brain = brain
    @player = player
  end

  def run
    create_player

    20.times do
      act_on(fetch_world)
    end
  end

  def act_on(world)
    perform_move(
      @brain.choose_move(world)
    )
  end

  def fetch_world
    Client.show_player
  end

  def perform_move(direction)
    print_response Client.move(direction)
  end

  def create_player
    Client.create_player(@player)
  end

  class Player < OpenStruct
  end

  class DumbBrain
    def choose_move(world)
      :NORTH
    end
  end

  class HungerAndThirstBrain
    def choose_move(world)
      nearest_food = nearest(world.board.select(&:is_food))
      nearest_water = nearest(world.board.select(&:is_water))
    end

    def nearest(player, resources)
      resources.sort_by { |r|
        (player.x - r.x).abs + (player.y - r.y).abs
      }.first(3)
    end
  end

  def print_response(response)
    puts response.instance_variable_get(:@data)
  end
end

