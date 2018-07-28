defmodule Import do
  @moduledoc """
  Documentation for Import.
  """

  def main(args) do
    args |> process
  end

  # Start processing if 2 args are supplied
  def process([source, path]) do
    IO.puts "I have 2 args: " <> source <> " and " <> path  
  end

  # Raise an error in any other cases
  def process(_) do
    Error.usage
  end
end
