defmodule Product do
  @enforce_keys [:title]
  defstruct [:title, categories: [], twitter: ""]

  @sourceStruct [{"capterra", [title: "name", categories: "tags", twitter: "twitter"]}, {"softwareadvice", [title: "title", categories: "categories", twitter: "twitter"]}]

  def createProductListFromFormat(mock, data, format) do
    case format do
      :json ->
        Enum.map(data["products"], fn p -> buildProduct mock, p end)
      :yaml ->
        Enum.map(data, fn p -> buildProduct mock, p end)
    end
  end

  def createProductList([source: source, path: path, format: format]) do
    mock = findMock source
    data = YamlElixir.read_from_file path
    case [mock, data] do
      [{:ok, m}, {:ok, d}] -> createProductListFromFormat m,d, format
      [{:error, _}, _] -> Error.mockError source
      [_, {:error, _}] -> Error.invalidFile path
    end
  end

  def importProduct(prod) do
    cats = Enum.join(prod.categories, ", ")
    IO.puts "importing: Name: #{prod.title}; Categories: #{cats}; Twitter: #{prod.twitter}"
  end

  def findMock(source) do
    f = Enum.find(@sourceStruct, fn {src, data} -> src == source end)
    case f do
      nil -> {:error, "unknown source"}
      {source, data} -> {:ok, data}
    end
  end

  def buildProduct(mock, data) do
    title = data[mock[:title]]
    categories = getCategories(data[mock[:categories]])
    case title do
      "" -> {:error, "Product name cannot be empty"}
      nil -> {:error, "Product may have a #{mock[:title]} field"}
      _ -> {:ok, %Product{title: title, categories: categories, twitter: data[mock[:twitter]]}}
    end
  end

  def getCategories(cat) when is_list(cat) do
    cat
  end
  
  def getCategories(cat) when is_binary(cat) do
   String.split(cat, ",")
  end
end
