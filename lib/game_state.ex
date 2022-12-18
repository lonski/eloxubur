defmodule Creature do
  defstruct pos: {0, 0}
end

defmodule GameState do
  def new(width, height) do
    dungeon = Dungeon.generate(width, height)

    %{
      screen: :play_screen,
      dungeon: dungeon,
      player: %Creature{pos: find_valid_player_start_position(width, height, dungeon)}
    }
  end

  defp find_valid_player_start_position(width, height, dungeon) do
    {x, y} = {:rand.uniform(width), :rand.uniform(height)}

    case Grid.at(dungeon, {x, y}) do
      '#' -> find_valid_player_start_position(width, height, dungeon)
      '.' -> {x, y}
    end
  end

  def move_player_by(%{dungeon: dungeon, player: player} = state, {dx, dy}) do
    {x, y} = player.pos

    player =
      if Grid.at(dungeon, {x + dx, y + dy}) == '.' do
        %{player | pos: {x + dx, y + dy}}
      else
        %{player | pos: {x, y}}
      end

    %{state | player: player}
  end
end
