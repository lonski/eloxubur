defmodule GridTest do
  use ExUnit.Case

  test "creates a grid" do
    grid = Grid.new(3,4,'#')

    assert :array.size(grid) == 4
    assert (:array.get(0, grid) |> :array.size) == 3
  end

  test "sets and gets a cell" do
    grid = Grid.new(3,4,'#') |> Grid.set(1,0,'@')

    assert (grid |> Grid.at(1,0)) == '@'
  end

  test "reads dimensions" do
    grid = Grid.new(3,4,'#')

    assert Grid.width(grid) == 3
    assert Grid.height(grid) == 4
  end

  test "checks if coords are in bounds" do
    grid = Grid.new(3,4,'#')

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
    s = Grid.new(3,4,'#') |> Grid.to_string

    assert s == "###\n###\n###\n###\n"
  end

  test "sets cells from list" do
    grid = Grid.new(3, 4, '#') 
            |> Grid.set([{1, 0}, {2, 0}, {1, 1}], '.') 
            |> Grid.to_string
      
    assert grid == "#..\n#.#\n###\n###\n"
  end

end
