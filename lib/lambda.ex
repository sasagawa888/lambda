defmodule Lambda do
  

    def gettoken() do
      IO.read(:stdio,1)
    end

    def test() do
      IO.puts(gettoken())
      IO.puts(gettoken())
      IO.puts(gettoken())
    end

end
