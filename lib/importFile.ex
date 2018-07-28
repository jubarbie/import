defmodule ImportFile do
  @moduledoc """
  Module that handles files for data importation
  """

  @allowedFormats [{:json, ".json"}, {:yaml, ".yaml"}]

  def allowedFormats, do: @allowedFormats

  def getFormat({:path, path}) do
    ext = Path.extname path
    find = Enum.find(@allowedFormats, nil, fn({_, e}) -> ext == e end)
    case find do
      {format, _} -> {:ok, format}
      _ -> {:error, "File format not supported"}
    end
  end

end
