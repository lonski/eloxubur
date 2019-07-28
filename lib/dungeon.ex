defmodule Dungeon do

  def generate(width, height) do
    grid = Grid.new(width, height, '#')
    pos = get_random_point(width, height)
    size = {:rand.uniform(6) + 2, :rand.uniform(6) + 2}
    grid = try_make_room(grid, size, pos)
    grid
  end

  defp try_make_room(grid, {x_size, y_size}, {x, y}) do 
    {ex, ey} = {x + x_size, y + y_size}
    case Grid.in_bounds?(grid, ex+1, ey+1) do
      true -> draw_room(grid, {x, y}, {ex, ey})
      false -> grid
    end
  end

  defp draw_room(grid, {sx, sy}, {ex, ey}) do
    room_points = for x <- sx..ex, y <- sy..ey, do: {x, y}
    Grid.set(grid, room_points, '.')
  end

  defp get_random_point(width, height) do
    {:rand.uniform(width-1), :rand.uniform(height-1)}
  end
end
