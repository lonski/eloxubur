defmodule GridTest do
  use ExUnit.Case

  test "creates a grid" do
    grid = Grid.create(3,4,'#')

    assert length(grid) == 4
    assert (grid |> Enum.at(0) |> length) == 3
    assert (grid |> Enum.flat_map(&(&1)) |> Enum.join) == "############"
  end

  test "sets a cell" do
    grid = Grid.create(3,4,'#') |> Grid.set(1,0,'@')

    assert (grid |> Enum.at(0) |> Enum.join) == "#@#"
  end

  test "gets a cell value" do
    cell = Grid.create(3,4,'#') |> Grid.set(1,0,'@') |> Grid.at(1,0)

    assert cell == '@'
  end

  test "reads dimensions" do
    grid = Grid.create(3,4,'#')

    assert Grid.width(grid) == 3
    assert Grid.height(grid) == 4
  end

  test "checks if coords are in bounds" do
    grid = Grid.create(3,4,'#')

    assert Grid.in_bounds?(grid, 0, 0) == true
    assert Grid.in_bounds?(grid, 2, 0) == true
    assert Grid.in_bounds?(grid, 0, 3) == true
    assert Grid.in_bounds?(grid, 2, 3) == true
    assert Grid.in_bounds?(grid, -1, 0) == false
    assert Grid.in_bounds?(grid, 0, -1) == false
    assert Grid.in_bounds?(grid, 3, 0) == false
    assert Grid.in_bounds?(grid, 0, 4) == false
  end

  test "generates a string representation" do
    s = Grid.create(3,4,'#') |> Grid.to_string

    assert s == "###\n###\n###\n###\n"
  end

end
