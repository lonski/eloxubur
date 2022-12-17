defmodule Dungeon do
  @fill_threshold 0.3
  @room_chance_percent 10
  @room_min 3
  @room_max 8
  @corridor_min 4
  @corridor_max 8

  def generate(width, height) do
    grid = Grid.new(width, height, '#')
    start_pos = {div(width, 2), div(height, 2)}

    add_features(grid, start_pos, @fill_threshold)
  end

  def fill_level(grid) do
    max(Grid.count(grid, '.'), 1) / max(Grid.count(grid, '#'), 1)
  end

  defp add_features(grid, pos, trsh) do
    {points, new_pos} =
      case :rand.uniform(100) < @room_chance_percent do
        true ->
          points = make_room(pos, random_direction())
          {points, Enum.random(points)}

        false ->
          points = make_corridor(pos, random_direction())
          {points, hd(points)}
      end

    {grid, pos} =
      case try_put(grid, points) do
        {:ok, grid} -> {grid, new_pos}
        {:fail, grid} -> {grid, pos}
      end

    if fill_level(grid) < trsh, do: add_features(grid, pos, trsh), else: grid
  end

  defp try_put(grid, points) do
    case Grid.in_bounds?(grid, points, 1) do
      true -> {:ok, Grid.set(grid, points, '.')}
      false -> {:fail, grid}
    end
  end

  defp make_room({sx, sy}, {dir_x, dir_y}) do
    {x_size, y_size} = {random(@room_min, @room_max), random(@room_min, @room_max)}
    x_size = if dir_x != 0, do: x_size * dir_x, else: x_size
    y_size = if dir_y != 0, do: y_size * dir_y, else: y_size
    {ex, ey} = {sx + dir_x + x_size, sy + dir_y + y_size}
    rect_points({sx, sy}, {ex, ey})
  end

  defp make_corridor({sx, sy}, {dir_x, dir_y}) do
    len = random(@corridor_min, @corridor_max)
    {ex, ey} = {sx + dir_x * len, sy + dir_y * len}
    rect_points({sx, sy}, {ex, ey})
  end

  defp rect_points({sx, sy}, {ex, ey}) do
    for x <- ex..sx, y <- ey..sy, do: {x, y}
  end

  defp random_direction() do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}] |> Enum.reverse() |> Enum.random()
  end

  defp random(from, to), do: :rand.uniform(to - from - 1) + from - 1
end
