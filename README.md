# lambda interpreter
An interpreter of Church's lambda calculaus.

# Usage
 ```
 mix lambda
 then display prompt '>'

λ is substituted with the ^ symbol.
For example λx.x-> ^x.x
The outermost λ expression can omit the parentheses.
 ```

### Shorthand
^xyz.x -> ^x.(^y.(^z.x))

### Variables are lowercase alphabet a-z. 
### Uppercase ISKY is reserved for combinators.

### quit
Input the atom 'end' and exit repl.

# Examples of running

```
mix lambda
>(^y.y((^z.xz)(^z.z)))(^a.a)
((^y.(y((^z.(xz))(^z.z))))(^a.a))
^a.a((^z.(xz))(^z.z))
((^z.(xz))(^z.z))
x(^z.z)

>SKKa
((^x.(^y.(^z.(xz(yz)))))(^x.(^y.x)))(^x.(^y.x))a
((^x.(^y.(^z.(xz(yz)))))(^x.(^y.x)))(^x.(^y.x))
((^x.(^y.(^z.(xz(yz)))))(^x.(^y.x)))
^y.(^z.(^x.(^y.x)z(yz)))
^z.(^x.(^y.x)z(yz))
^x.(^y.x)z(yz)

^x.(^y.x)z
^y.z
^y.z
^y.z(yz)
^y.(^z.z)
^z.z
((^y.(^z.z))(^x.(^y.x)))
^z.z
^z.z
^z.za
a
>end
```