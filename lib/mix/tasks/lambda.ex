defmodule Mix.Tasks.Lambda do
  use Mix.Task

  @shortdoc "Lambda interpreter mix"

  def run(_) do
    Lambda.lambda()
  end
end
