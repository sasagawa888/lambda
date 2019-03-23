defmodule LambdaTest do
  use ExUnit.Case
  doctest Lambda


  test "parse test" do
    assert Lambda.parse('xy\n',[]) == [:x, :y]
    #assert Lambda.parse('(xy)\n',[]) == [:x, :y]
    #assert Lambda.parse('^x.y\n',[]) == [{:^, :x , [:y]}]
    #assert Lambda.parse('^x.(^y.y)\n',[]) == [{:^, :x, [{:^, :y, [:y]}]}]
    #assert Lambda.parse('(^x.x)(^y.y)\n',[]) == [{:^ , :x , [:x]},{:^, :y, [:y]}]
    #assert Lambda.parse('^x.xy\n',[]) == [{:^,:x,[:x,:y]}]
    #assert Lambda.parse('xyz\n',[]) == [[:x,:y],:z]
    #assert Lambda.parse('abcd\n',[]) == [[[:a,:b],:c],:d]
    #assert Lambda.parse('(^xy.x)\n',[]) == [{:^,:x,{:^,:y,[:x]}}]
    #assert Lambda.parse('(^xyz.x)\n',[]) == [{:^ ,:x,[{:^,:y,{:^,:z,[:x]}}]}]
    #assert Lambda.parse('(xy)z\n',[]) == [[:x,:y],:z]
    #assert Lambda.parse('x(yz)\n',[]) == [:x,[:y,:z]]
    #assert Lambda.parse('a(b(cd))\n',[]) == [:a,[:b,[:c,:d]]]

  end
end
