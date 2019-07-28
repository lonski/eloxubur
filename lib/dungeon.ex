defmodule Dungeon do
  def generate(width, height) do
    grid = Grid.new(width, height, '#')
    start_pos = {div(width, 2), div(height, 2)}

    add_feature(grid, start_pos, 0.6)
  end

  def fill_level(grid) do
    max(Grid.count(grid, '.'), 1) / max(Grid.count(grid, '#'), 1)
  end

  defp add_feature(grid, pos, trsh) do
    {grid, pos} =
      case :rand.uniform(10) < 3 do
        true -> try_make_room(grid, pos, random_direction())
        false -> try_make_corridor(grid, pos, random_direction())
      end

    if fill_level(grid) < trsh, do: add_feature(grid, pos, trsh), else: grid
  end

  defp try_make_room(grid, {sx, sy}, {dir_x, dir_y}) do
    {x_size, y_size} = {random(3, 8), random(3, 8)}
    {ex, ey} = {sx + dir_x + x_size, sy + dir_y + y_size}
    points = rect_points({sx, sy}, {ex, ey})

    case Grid.in_bounds?(grid, points, 1) do
      true -> {Grid.set(grid, points, '.'), Enum.random(points)}
      false -> {grid, {sx, sy}}
    end
  end

  defp try_make_corridor(grid, {sx, sy}, {dir_x, dir_y}) do
    len = random(4, 10)
    {ex, ey} = {sx + dir_x * len, sy + dir_y * len}
    points = rect_points({sx, sy}, {ex, ey})

    case Grid.in_bounds?(grid, points, 1) do
      true -> {Grid.set(grid, points, '.'), hd(points)}
      false -> {grid, {sx, sy}}
    end
  end

  defp rect_points({sx, sy}, {ex, ey}) do
    for x <- ex..sx, y <- ey..sy, do: {x, y}
  end

  defp random_direction() do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}] |> Enum.random()
  end

  defp random(from, to), do: :rand.uniform(to - from - 1) + from - 1
end
