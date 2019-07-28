defmodule Grid do

  def create(width, height, c) do
    c |> List.duplicate(width) |> List.duplicate(height)
  end

  def at(grid, x, y) do
    grid |> Enum.at(y) |> Enum.at(x)
  end

  def set(grid, x, y, c) do
    new_row = grid |> Enum.at(y) |> List.replace_at(x, c) 
    List.replace_at(grid, y, new_row)
  end

  def width(grid) do
    grid |> Enum.at(0) |> length
  end

  def height(grid) do
    grid |> length
  end

  def in_bounds?(grid, x, y) do
    x >= 0 && y >= 0 && x < Grid.width(grid) && y < Grid.height(grid)
  end

  def to_string(grid) do
    grid 
      |> Stream.map(&List.to_string/1) 
      |> Enum.map(fn r -> r <> "\n" end)
      |> Enum.join
  end
  
end

