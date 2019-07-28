defmodule GridTest do
  use ExUnit.Case

  test "creates a grid" do
    grid = Grid.new(3, 4, '#')

    assert :array.size(grid) == 4
    assert :array.get(0, grid) |> :array.size() == 3
  end

  test "sets and gets a cell" do
    grid = Grid.new(3, 4, '#') |> Grid.set(1, 0, '@')

    assert grid |> Grid.at({1, 0}) == '@'
  end

  test "reads dimensions" do
    grid = Grid.new(3, 4, '#')

    assert Grid.width(grid) == 3
    assert Grid.height(grid) == 4
  end

  test "checks if coords are in bounds" do
    grid = Grid.new(3, 4, '#')

    assert Grid.in_bounds?(grid, {0, 0}) == true
    assert Grid.in_bounds?(grid, [{2, 0}, {0, 3}, {2, 3}]) == true
    assert Grid.in_bounds?(grid, {-1, 0}) == false
    assert Grid.in_bounds?(grid, {0, -1}) == false
    assert Grid.in_bounds?(grid, {3, 0}) == false
    assert Grid.in_bounds?(grid, {0, 4}) == false
    assert Grid.in_bounds?(grid, {2, 3}, 1) == false
  end

  test "generates a string representation" do
    s = Grid.new(3, 4, '#') |> Grid.to_string()

    assert s == "###\n###\n###\n###\n"
  end

  test "sets cells from list" do
    grid =
      Grid.new(3, 4, '#')
      |> Grid.set([{1, 0}, {2, 0}, {1, 1}], '.')
      |> Grid.to_string()

    assert grid == "#..\n#.#\n###\n###\n"
  end

  test "counts cells" do
    g = Grid.new(3, 4, '#')
    assert g |> Grid.count('#') == 12
    assert g |> Grid.count('.') == 0
    g = g |> Grid.set(0, 0, '.')
    assert g |> Grid.count('#') == 11
    assert g |> Grid.count('.') == 1
  end

  test "checks if all points have given char" do
    g = Grid.new(3, 4, '#') |> Grid.set(0, 0, '.')

    assert Grid.all?(g, [{0, 1}, {1, 1}], '#') == true
    assert Grid.all?(g, [{0, 0}], '.') == true
    assert Grid.all?(g, [{0, 0}, {0, 1}], '.') == false
  end
end
