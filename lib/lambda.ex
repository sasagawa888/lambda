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
      {exp,ls1} = parse1(ls,[])
      if is_lambda(exp) do
        parse(ls1,res++[exp])
      else
        parse(ls1,res++exp)
      end
    end
    def parse([41|ls],res) do
      parse(ls,res)
    end
    def parse([l1,l2|ls],res) when l2 < 48 do
      if is_lambda(hd(res)) do
        parse([l2]++ls,res++[String.to_atom(<<l1>>)])
      else
        parse([l2]++ls,[res]++[String.to_atom(<<l1>>)])
      end
    end
    def parse([l1,l2|ls],[]) do
      parse(ls,[String.to_atom(<<l1>>),String.to_atom(<<l2>>)])
    end
    def parse([l1,l2|ls],res) do
      parse([l2]++ls,[res]++[String.to_atom(<<l1>>)])
    end

    def parse1([94,arg,46|ls],res) do
      arg1 = String.to_atom(<<arg>>)
      {body,ls1} = parse1(ls,res)
      {{:^,arg1,body},ls1}
    end
    def parse1([94,arg|ls],res) do
      arg1 = String.to_atom(<<arg>>)
      {body,ls1} = parse1([94|ls],res)
      {{:^,arg1,body},ls1}
    end
    def parse1([40|ls],_) do
      {exp,[41|ls1]} = parse1(ls,[])
      {exp,ls1}
    end
    # x )
    def parse1([l1,l2|ls],_) when l2 < 48 do
      {String.to_atom(<<l1>>),[l2]++ls}
    end
    def parse1([l1,l2|ls],_) do
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
      print1(x)
      print(y)
    end
    def print([x]) do
      IO.write(x)
    end

    def print1({:^,x,y}) do
      IO.write("(^")
      IO.write(x)
      IO.write(".")
      print1(y)
      IO.write(")")
    end
    def print1(e) do
      IO.write(e)
    end

    def is_lambda({:^,_,_}) do true end
    def is_lambda(_) do false end

    def reduce(:end) do
      throw "end"
    end
    def reduce([x]) do [x] end
    def reduce([x,y]) do
      if is_lambda(x) do
        beta(x,y)
      else
        [x,y]
      end
    end

    def beta({:^,arg,body},y) do
      [replace(arg,body,y)]
    end

    def replace(x,x,z) do
      z
    end

end
