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
          #:io.write(read())
          print(reduce(read()))
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
    # ( )
    def parse([40|ls],res) do
      #IO.inspect binding()
      {exp,ls1} = parse1(ls,[])
      cond do
        is_lambda(exp) -> parse(ls1,res++[exp])
        res == [] -> parse(ls1,exp)
        true -> parse(ls1,res++[exp])
      end
    end
    def parse([41|ls],res) do
      #IO.inspect binding()
      parse(ls,res)
    end
    def parse([l1,40|ls],[]) do
      #IO.inspect binding()
      parse([40]++ls,[String.to_atom(<<l1>>)])
    end
    def parse([l1,40|ls],res) do
      #IO.inspect binding()
      parse([40]++ls,[res]++[String.to_atom(<<l1>>)])
    end
    def parse([l1,l2|ls],res) when l2 < 48 do
      #IO.inspect binding()
      if res != [] and is_lambda(hd(res)) do
        parse([l2]++ls,res++[String.to_atom(<<l1>>)])
      else
        parse([l2]++ls,[res]++[String.to_atom(<<l1>>)])
      end
    end
    def parse([l1,l2|ls],[]) do
      #IO.inspect binding()
      parse(ls,[String.to_atom(<<l1>>),String.to_atom(<<l2>>)])
    end
    def parse([l1,l2|ls],res) do
      #IO.inspect binding()
      parse([l2]++ls,[res]++[String.to_atom(<<l1>>)])
    end

    def parse1([94,arg,46|ls],res) do
      #IO.inspect binding()
      arg1 = String.to_atom(<<arg>>)
      {body,ls1} = parse1(ls,res)
      {{:^,arg1,body},ls1}
    end
    def parse1([94,arg|ls],res) do
      #IO.inspect binding()
      arg1 = String.to_atom(<<arg>>)
      {body,ls1} = parse1([94|ls],res)
      {{:^,arg1,body},ls1}
    end
    def parse1([40|ls],_) do
      #IO.inspect binding()
      {exp,[41|ls1]} = parse1(ls,[])
      {exp,ls1}
    end
    # x )
    def parse1([l1,l2|ls],_) when l2 < 48 do
      #IO.inspect binding()
      {String.to_atom(<<l1>>),[l2]++ls}
    end
    def parse1([l1,l2|ls],_) do
      #IO.inspect binding()
      {[String.to_atom(<<l1>>),String.to_atom(<<l2>>)],ls}
    end

    def print([]) do end
    def print([{:^,x,y}]) do
      IO.write("^")
      IO.write(x)
      IO.write(".")
      print1(y)
    end
    def print([x,y]) do
      #IO.inspect binding()
      print1(x)
      print([y])
    end
    def print([x]) when is_list(x) do
      #IO.inspect binding()
      print(x)
    end
    def print([x]) do
      #IO.inspect binding()
      IO.write(x)
    end


    def print1({:^,x,y}) do
      #IO.inspect binding()
      IO.write("(^")
      IO.write(x)
      IO.write(".")
      print1(y)
      IO.write(")")
    end
    def print1([l|ls]) do
      print1(l)
      print(ls)
    end
    def print1(e) do
      #IO.inspect binding()
      IO.write(e)
    end

    def is_lambda({:^,_,_}) do true end
    def is_lambda(_) do false end

    def reduce(:end) do
      throw "end"
    end
    def reduce([x]) do [x] end
    #IO.inspect binding()
    def reduce([:I,y]) do
      reduce([{:^,:x,:x},y])
    end
    def reduce([x,y]) do
    #IO.inspect binding()
      if is_lambda(x) do
        beta(x,y)
      else
        [x,y]
      end
    end

    def beta({:^,arg,body},y) do
    #IO.inspect binding()
      [replace(arg,body,y)]
    end

    def replace(x,x,z) when is_atom(x) do z end
    def replace(_,y,z) when is_atom(y) do z end
    def replace(x,{:^,a,y},z) do
      {:^,a,replace(x,y,z)}
    end
    def replace(x,[y|ys],z) do
      [y] ++ replace(x,ys,z)
    end

end
