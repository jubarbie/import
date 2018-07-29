defmodule Import do
  @moduledoc """
  Documentation for Import.
  """

  def main(args) do
    args |> process
  end

  # Start processing if 2 args are supplied
  def process([source, path]) do
    res = ImportFile.getFormat {:path, path}
    case res do
      {:ok, format} ->
        [source: source, path: path] |> Product.createProductList |> Enum.map (fn {:ok, p} -> Product.importProduct p end)
      _ -> Error.fileFormat [path: path]
    end
  end

  # Raise an error in any other cases
  def process(_) do
    Error.usage
  end
end
