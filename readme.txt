An interpreter of Church's lambda calculaus. I'm writing to learn Elixir.

Usage
 iex -S mix
 Lambda.repl

ƒÉ is substituted with the ^ symbol.
For example ƒÉx.x-> ^ x.x
The outermost ƒÉ expression can omit the parentheses.

Variables are lowercase alphabet a-z. Uppercase ISKY is reserved for combinators.

quit
Input the atom [end] and exit repl.

Examples of running
iex -S mix
iex(1)> Lambda.repl()
>(^y.y((^z.xz)(^z.z)))(^a.a)
x(^z.z)
>SKKa
a
>end
endnil
iex(2)>
