defmodule LambdaTest do
  use ExUnit.Case
  doctest Lambda

  test "reduce test1" do
    assert Lambda.reduce([:y]) == [:y]
  end
end
