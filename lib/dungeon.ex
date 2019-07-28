defmodule Dungeon do
  @fill_treshold 0.6
  @room_chance_percent 10
  @room_size_min 3
  @room_size_max 8
  @corridor_len_min 4
  @corridor_len_max 10

  def generate(width, height) do
    grid = Grid.new(width, height, '#')
    start_pos = {div(width, 2), div(height, 2)}

    add_features(grid, start_pos, @fill_treshold)
  end

  def fill_level(grid) do
    max(Grid.count(grid, '.'), 1) / max(Grid.count(grid, '#'), 1)
  end

  defp add_features(grid, pos, trsh) do
    {grid, pos} =
      case :rand.uniform(100) < @room_chance_percent do
        true -> try_make_room(grid, pos, random_direction())
        false -> try_make_corridor(grid, pos, random_direction())
      end

    if fill_level(grid) < trsh, do: add_features(grid, pos, trsh), else: grid
  end

  defp try_make_room(grid, {sx, sy}, {dir_x, dir_y}) do
    {x_size, y_size} = {
      random(@room_size_min, @room_size_max),
      random(@room_size_min, @room_size_max)
    }

    {ex, ey} = {sx + dir_x + x_size, sy + dir_y + y_size}
    points = rect_points({sx, sy}, {ex, ey})

    case Grid.in_bounds?(grid, points, 1) do
      true -> {Grid.set(grid, points, '.'), Enum.random(points)}
      false -> {grid, {sx, sy}}
    end
  end

  defp try_make_corridor(grid, {sx, sy}, {dir_x, dir_y}) do
    len = random(@corridor_len_min, @corridor_len_max)
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
