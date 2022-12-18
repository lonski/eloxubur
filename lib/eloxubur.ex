defmodule Eloxubur do
  @behaviour Ratatouille.App

  import GameState

  def init(context) do
    GameState.new(context[:window][:width], context[:window][:height])
  end

  def update(state, {:event, %{ch: ch}}) do
    ScreenLogic.update(state, ch)
  end

  def render(state) do
    ScreenUi.render(state)
  end
end

Ratatouille.run(Eloxubur)
