defmodule ScreenUi do
  import Ratatouille.View

  def render(%{screen: :play_screen, player: p, dungeon: d}) do
    d = d |> Grid.set([p.pos], '@')

    view do
      for y <- 0..(Grid.height(d) - 1) do
        label(content: List.to_string(:array.to_list(:array.get(y, d))))
      end
    end
  end
end
