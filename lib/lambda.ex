defmodule Lambda do
  @moduledoc """
  Documentation for Lambda.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Lambda.hello()
      :world

  """

    def repl() do
      try do
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
    def parse([94|_],_) do
      throw("syntax error")
    end
    # ( )
    def parse([40|ls],res) do
      {exp,ls1} = parse1(ls,[])
      parse(ls1,res++[exp])
    end
    def parse([41|ls],res) do
      parse(ls,res)
    end
    def parse([l|ls],res) do
      parse(ls,res++[String.to_atom(<<l>>)])
    end

    def parse1([94,arg,46|ls],res) do
      arg1 = String.to_atom(<<arg>>)
      {body,ls1} = parse1(ls,res)
      {{:^,arg1,body},ls1}
    end
    def parse1([94|_],_) do
      throw("syntax error")
    end
    def parse1([40|ls],_) do
      {exp,[41|ls1]} = parse1(ls,[])
      {exp,ls1}
    end
    def parse1([l|ls],_) do
      {String.to_atom(<<l>>),ls}
    end

    def print([]) do end
    def print([{:^,x,y}]) do
      IO.write("^")
      IO.write(x)
      IO.write(".")
      print1(y)
    end
    def print([{:^,x,y},z]) do
      print1({:^,x,y})
      print1(z)
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

    def reduce(:end) do
      throw "end"
    end
    def reduce([x]) do [x] end
    def reduce([x,y]) do
      beta(x,y)
    end

    def beta({:^,arg,body},y) do
      [replace(arg,body,y)]
    end

    def replace(x,x,z) do
      z
    end

end
