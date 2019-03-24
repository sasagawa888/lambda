An interpreter of Church's lambda calculaus. I'm writing to learn Elixir.

Usage:
 iex -S mix
 Lambda.repl

λ is substituted with the ^ symbol.
For example λx.x-> ^ x.x
The outermost λ expression can omit the parentheses.

Shorthand
^xyz.x -> ^x.(^y.(^z.x))
Variables are lowercase alphabet a-z. Uppercase ISKY is reserved for combinators.

quit:
Input the atom [end] and exit repl.

Examples of running:
iex -S mix
iex(1)> Lambda.repl()
>(^y.y((^z.xz)(^z.z)))(^a.a)
x(^z.z)
>SKKa
a
>end
endnil
iex(2)>
