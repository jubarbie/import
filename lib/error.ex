defmodule Error do

  # Print usage
  def usage do
    IO.puts :stderr, "Usage: import source path/to/file"
    System.halt(1)
  end

  def fileFormat(err) do
    allowed = Enum.map_join(ImportFile.allowedFormats, ", ", fn ({_, ext}) -> ext end)
    IO.puts :stderr, "File format error: " <> err[:path]
    IO.puts :stderr, "Accepted formats: #{allowed}"
    System.halt(1)
  end
  
  def mockError(source) do
    IO.puts :stderr, "Unknown source: #{source}"
    System.halt(1)
  end

  def invalidFile(path) do
    IO.puts :stderr, "Invalid file: #{path}"
    System.halt(1)
  end

end
