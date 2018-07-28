defmodule Error do

  # Print usage
  def usage do
    IO.puts :stderr, "Usage: import source path/to/file"
    System.halt(0)
  end

end
