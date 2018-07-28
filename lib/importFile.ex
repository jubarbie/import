defmodule ImportFile do
  @moduledoc """
  Module that handles files for data importation
  """

  @allowedFormats [{:json, ".json"}, {:yaml, ".yaml"}]

  def checkFormat({:path, path}) do
    ext = Path.extname path
    find = Enum.find(@allowedFormats, nil, fn({_, e}) -> ext == e end)
    case find do
      {format, _} -> {:ok, [path: path, format: format]}
      _ -> {:nok, [path: path]}
    end
  end

end
