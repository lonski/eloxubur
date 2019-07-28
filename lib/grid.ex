defmodule Grid do
  def new(width, height, c) do
    row = :array.new([{:size, width}, {:fixed, true}, {:default, c}])
    :array.new([{:size, height}, {:fixed, true}, {:default, row}])
  end

  def at(grid, x, y) do
    row = :array.get(y, grid)
    :array.get(x, row)
  end

  def set(grid, x, y, c) do
    row = :array.get(y, grid)
    row = :array.set(x, c, row)
    :array.set(y, row, grid)
  end

  def set(grid, [{x, y} | t], c) do
    set(set(grid, x, y, c), t, c)
  end

  def set(grid, [], _c), do: grid

  def width(grid) do
    :array.get(0, grid) |> :array.size()
  end

  def height(grid) do
    :array.size(grid)
  end

  def in_bounds?(grid, {x, y}, offset) do
    x >= offset &&
      y >= offset &&
      x + offset < Grid.width(grid) - offset &&
      y + offset < Grid.height(grid) - offset
  end

  def in_bounds?(grid, [h | t], offset) do
    in_bounds?(grid, h, offset) and in_bounds?(grid, t, offset)
  end

  def in_bounds?(grid, [], _), do: true
  def in_bounds?(grid, p, offset \\ 0), do: in_bounds?(grid, p, offset)

  def to_string(grid) do
    :array.to_list(grid)
    |> Stream.map(&:array.to_list/1)
    |> Stream.map(&List.to_string/1)
    |> Stream.map(fn r -> r <> "\n" end)
    |> Enum.join()
  end
end
