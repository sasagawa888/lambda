defmodule LambdaTest do
  use ExUnit.Case
  doctest Lambda

  test "total test" do
    assert Lambda.test('y\n') == :y
    assert Lambda.test('Iy\n') == :y
    assert Lambda.test('Is\n') == :s
    assert Lambda.test('Ks\n') == {:y,:s}
    assert Lambda.test('SKKa\n') == :a
    assert Lambda.test('(^y.y((^z.xz)(^z.z)))(^a.a)\n') == [:x,{:z,:z}]
  end

  test "reduce test" do
    assert Lambda.reduce(:y) == :y
    assert Lambda.reduce([:x, :y]) == [:x,:y]
    assert Lambda.reduce([{:x,:x}, :y]) == :y
  end
  test "parse test" do
    assert Lambda.parse('xy\n',[]) == [:x, :y]
    assert Lambda.parse('(xy)\n',[]) == [:x, :y]
    assert Lambda.parse('^x.y\n',[]) == {:x , :y}
    assert Lambda.parse('^x.(^y.y)\n',[]) == {:x, {:y, :y}}
    assert Lambda.parse('(^x.x)(^y.y)\n',[]) == [{:x , :x},{:y, :y}]
    assert Lambda.parse('^x.xy\n',[]) == {:x,[:x,:y]}
    assert Lambda.parse('^xy.z\n',[]) == {:x,{:y,:z}}
    assert Lambda.parse('^xyz.z\n',[]) == {:x,{:y,{:z,:z}}}
    assert Lambda.parse('xyz\n',[]) == [[:x,:y],:z]
    assert Lambda.parse('abcd\n',[]) == [[[:a,:b],:c],:d]
    assert Lambda.parse('(^x.y)\n',[]) == {:x,:y}
    assert Lambda.parse('(^xy.x)\n',[]) == {:x,{:y,:x}}
    assert Lambda.parse('(^xyz.x)\n',[]) == {:x,{:y,{:z,:x}}}
    assert Lambda.parse('(xy)z\n',[]) == [[:x,:y],:z]
    assert Lambda.parse('x(yz)\n',[]) == [:x,[:y,:z]]
    assert Lambda.parse('a(b(cd))\n',[]) == [:a,[:b,[:c,:d]]]

  end
end
