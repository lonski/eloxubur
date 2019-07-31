defmodule ScreenUi do
  import Ratatouille.View

  def render(%{screen: :play_screen, player: p, dungeon: d}) do
    d = d |> Grid.set([p.pos], '@')

    view do
      #for y <- 0..(Grid.height(d) - 1), x <- 0..(Grid.width(d) - 1) do
      for y <- 0..(Grid.height(d) - 1) do
        #canvas_cell(x: x, y: y, char: Grid.at(d, x, y))
        label(content: List.to_string(:array.to_list(:array.get(y, d))))
      end
    end
  end
end
