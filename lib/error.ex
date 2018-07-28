defmodule Error do

  # Print usage
  def usage do
    IO.puts :stderr, "Usage: import source path/to/file"
    System.halt(0)
  end

  def fileReading(path, err) do
    IO.puts "File error: " <> path
    case err do
      :enoent -> IO.puts "the file does not exist"
      :eacces -> IO.puts "missing permission for reading the file, or for searching one of the parent directories"
      :eisdir -> IO.puts "the named file is a directory"
      :enotdir -> IO.puts "a component of the file name is not a directory"
      :enomem -> IO.puts "there is not enough memory for the contents of the file"
    end
    System.halt(0)
  end

  def fileFormat(err) do
    allowed = Enum.map_join(ImportFile.allowedFormats, ", ", fn ({_, ext}) -> ext end)
    IO.puts "File format error: " <> err[:path]
    IO.puts "Accepted formats: #{allowed}"
    System.halt(0)
  end

end
