defmodule DungeonTest do
  use ExUnit.Case

  test 'generates non null dungeon' do
    d = Dungeon.generate(60,20)

    assert d != nil
    IO.puts "\n"
    IO.puts Grid.to_string(d)
  end

end
