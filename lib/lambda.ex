defmodule Lambda do
  @moduledoc """
  Documentation for Lambda.
  """

  @doc """
  Hello world.

  ## Examples

      #iex> Lambda.hello()
      #:world

  """

    def repl() do
      try do
          #:io.write(reduce(combinator(read())))
          print(beta(combinator(read())))
          repl()
      catch
        x -> IO.write(x)
        if x != "end" do
          repl()
        end
      end
    end

    def read() do
      IO.gets("\n>") |> String.to_charlist |> parse([])
    end


    # terminal
    def parse('\n',res) do res end
    def parse('end\n',_) do :end end
    # ^ arg .
    def parse([94,arg,46|ls],res) do
      arg1 = String.to_atom(<<arg>>)
      {body,ls1} = parse1(ls,[])
      parse(ls1,res++[{:^,arg1,body}])
    end
    def parse([94,arg|ls],_) do
      arg1 = String.to_atom(<<arg>>)
      [{:^,arg1,hd(parse([94|ls],[]))}]
    end
    def parse([l|ls],res) when l >= 65 and l <= 122 do
      #IO.inspect binding()
      cond do
        res == [] -> parse(ls,[String.to_atom(<<l>>)])
        length(res) == 1 ->  parse(ls,res++[String.to_atom(<<l>>)])
        true -> parse(ls,[res]++[String.to_atom(<<l>>)])
      end
    end
    # ( )
    def parse([40|ls],res) do
      #IO.inspect binding()
      {exp,ls1} = parse1([40|ls],[])
      cond do
        is_lambda(exp) -> parse(ls1,res++[exp])
        res == [] -> parse(ls1,exp)
        true -> parse(ls1,res++[exp])
      end
    end
    #space skip
    def parse([32|ls],res) do
      parse(ls,res)
    end
    def parse(_,_) do
      #IO.inspect binding()
      throw "syntax error"
    end


    def parse1([94,arg,46|ls],res) do
      #IO.inspect binding()
      arg1 = String.to_atom(<<arg>>)
      {body,ls1} = parse1(ls,res)
      {{:^,arg1,body},ls1}
    end
    def parse1([94,arg|ls],_) do
      #IO.inspect binding()
      arg1 = String.to_atom(<<arg>>)
      {body,ls1} = parse1([94|ls],[])
      {[{:^,arg1,body}],ls1}
    end
    def parse1([l|ls],res) when l >= 65 and l <= 122 do
      #IO.inspect binding()
      cond do
        res == [] -> parse1(ls,[String.to_atom(<<l>>)])
        length(res) == 1 ->  parse1(ls,res++[String.to_atom(<<l>>)])
        true -> parse1(ls,[res]++[String.to_atom(<<l>>)])
      end
    end
    def parse1([40|ls],res) do
      #IO.inspect binding()
      {exp,[41|ls1]} = parse1(ls,[])
      cond do
        res == [] -> {exp,ls1}
        length(res) == 1 -> {res++[exp],ls1}
        true -> {[res]++exp,ls1}
      end
    end
    def parse1([41|ls],res) do
      #IO.inspect binding()
      {res,[41|ls]}
    end
    def parse1('\n',res) do
      #IO.inspect binding()
      {res,'\n'}
    end
    def parse1(_,_) do
      #IO.inspect binding()
      throw "syntax error1"
    end


    def print([]) do end
    def print(x) when is_atom(x) do
      IO.write(x)
    end
    def print({:^,x,y}) do
      IO.write("^")
      IO.write(x)
      IO.write(".")
      print1(y)
    end
    def print([{:^,x,y}]) do
      IO.write("^")
      IO.write(x)
      IO.write(".")
      print1(y)
    end
    def print([x|xs]) do
      #IO.inspect binding()
      print(x)
      print(xs)
    end

    def print1({:^,x,y}) do
      #IO.inspect binding()
      IO.write("(^")
      IO.write(x)
      IO.write(".")
      print1(y)
      IO.write(")")
    end
    def print1([x,y]) when is_atom(x) and is_atom(y) do
      IO.write("(")
      IO.write(x)
      IO.write(y)
      IO.write(")")
    end
    def print1([l|ls]) do
      print1(l)
      print1(ls)
    end
    def print1(e) do
      #IO.inspect binding()
      IO.write(e)
    end

    def is_lambda({:^,_,_}) do true end
    def is_lambda(_) do false end


    def combinator(:I) do {:^,:x,[:x]} end
    def combinator(:K) do {:^,:x,[{:^,:y,[:x]}]} end
    def combinator(:S) do {:^,:x,[{:^,:y,[{:^,:z,[:x,[:z,[:y,:z]]]}]}]} end
    def combinator([x,y]) do
      [combinator(x)]++[combinator(y)]
    end
    def combinator(x) do x end

    def beta(:end) do throw "end" end
    def beta([x]) when is_atom(x) do [x] end
    def beta([x]) when is_list(x) do [x] end
    def beta([x,y]) when is_atom(x) do [x,y] end
    def beta([{:^,a,body}]) do
      [{:^,a,beta(body)}]
    end
    def beta([x,y]) do
      print([x,y])
      IO.write('\n')
      if is_lambda(x) do
        beta1(x,y)
      else
        exp = beta(x)
        if is_lambda(exp) do
          beta([exp,y])
        else
          [exp,y]
        end
      end
    end

    def beta1({:^,arg,body},y) do
    #IO.inspect binding()
      replace(arg,body,y) |> beta
    end

    def replace(_,[],_) do [] end
    def replace(x,[x|ys],z) do
      [z] ++ replace(x,ys,z)
    end
    def replace(x,[y|ys],z) when is_atom(y) do
      [y] ++ replace(x,ys,z)
    end
    def replace(x,[y|ys],z) do
      #IO.inspect binding()
      if(is_lambda(y)) do
        [replace1(x,y,z)] ++ replace(x,ys,z)
      else
        [replace(x,y,z)] ++ replace(x,ys,z)
      end
    end

    def replace1(x,{:^,a,y},z) do
      {:^,a,replace(x,y,z)}
    end
end
