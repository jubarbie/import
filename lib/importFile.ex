defmodule ImportFile do
  @moduledoc """
  Module that handles files for data importation
  """

  @allowedFormats [{:json, ".json"}, {:yaml, ".yaml"}]

  def allowedFormats, do: @allowedFormats

  def checkFormat({:path, path}) do
    ext = Path.extname path
    find = Enum.find(@allowedFormats, nil, fn({_, e}) -> ext == e end)
    case find do
      {format, _} -> {:ok, [path: path, format: format]}
      _ -> {:error, [path: path, message: "File format not supported"]}
    end
  end

  def getFileContent({:ok, [path: path, format: format]}) do
    case File.read(path) do
      {:ok, content} -> {:ok, [path: path, format: format, content: content]}
      {:error, error} -> Error.fileReading path, error
    end
  end

  def getFileContent({:error, data}) do
    Error.fileFormat(data)
  end

  def printFileContent({:ok, data}) do
    IO.puts data[:content]
  end
  
  def printFileContent({:error, error}) do
    IO.puts "Error while reading file"
  end


end
