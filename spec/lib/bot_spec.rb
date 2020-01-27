require "mother"
require "./lib/bot"

describe Bot do
  it "can act on the world" do
  end

  describe Bot::HungerAndThirstBrain do
    let(:player) { Mother.create({"days_active" => 20, "water_count" => 3, "days_without_water" => 0, "food_count" => 1, "days_without_food" => 0, "active" => true, "x" => 18, "y" => 29}) }
    let(:board) do
      Mother.create [{"x" => 38, "y" => 29, "is_water" => false, "is_food" => true, "is_player" => false}, {"x" => 18, "y" => 11, "is_water" => true, "is_food" => false, "is_player" => false}, {"x" => 14, "y" => 29, "is_water" => true, "is_food" => false, "is_player" => false}, {"x" => 18, "y" => 1, "is_water" => true, "is_food" => false, "is_player" => false}, {"x" => 34, "y" => 29, "is_water" => false, "is_food" => false, "is_player" => true}]
    end

    it "does" do
      expect(Bot::HungerAndThirstBrain.new.nearest(player, board)).to eq(:junk)
    end
  end
end
