defmodule ScreenLogic do
  def update(%{screen: :play_screen} = state, ch) do
    case ch do
      ?j -> GameState.move_player_by(state, {0, 1})
      ?k -> GameState.move_player_by(state, {0, -1})
      ?l -> GameState.move_player_by(state, {1, 0})
      ?h -> GameState.move_player_by(state, {-1, 0})
      _ -> state
    end
  end
end
