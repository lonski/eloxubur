defmodule Creature do
  defstruct pos: {0, 0}
end

defmodule GameState do
  def new(width, height) do
    %{
      screen: :play_screen,
      dungeon: Dungeon.generate(width, height),
      player: %Creature{pos: {10, 10}}
    }
  end

  def move_player_by(%{player: player} = state, {dx, dy}) do
    {x, y} = player.pos
    player = %{player | pos: {x + dx, y + dy}}
    %{state | player: player}
  end
end
