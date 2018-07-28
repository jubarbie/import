defmodule Import do
  @moduledoc """
  Documentation for Import.
  """

  def main(args) do
    args |> process
  end

  # Start processing if 2 args are supplied
  def process([source, path]) do
    {:ok, format} = ImportFile.getFormat {:path, path}
    [source: source, path: path, format: format] |> Product.createProductList |> Enum.map (fn {:ok, p} -> Product.importProduct p end)
  end

  # Raise an error in any other cases
  def process(_) do
    Error.usage
  end
end
