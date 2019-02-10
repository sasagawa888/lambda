チャーチのラムダ算法による簡約化をするインタプリタです。
Elixirの習得のために書いています。

使い方
起動　iex -S mix
     Lambda.repl

λは　＾記号で代用します。例　λx.x -> ^x.x
一番外側のλ式はカッコを省略できます。

変数は小文字のアルファベットa-zです。
大文字のISKYはコンビネータのために予約されています。

終了　endと入れるとreplを抜けます。


参考文献
計算論　計算可能性とラムダ計算　高橋正子　著　近代科学社
