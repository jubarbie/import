defmodule Product do
  @enforce_keys [:title]
  defstruct [:title, categories: [], twitter: ""]

  # Data description for every sources, a list of what I call "mock"
  # This should be stored somewhere in the database
  @sourceStruct [%{source: "capterra", fields: [title: %{name: "name"}, categories: %{name: "tags", format: :string, separator: ","}, twitter: %{name: "twitter"}]}, %{source: "softwareadvice", fields: [title: %{name: "title"}, categories: %{name: "categories", format: :list}, twitter: %{name: "twitter"}], data: "products"}]
  
  # Parse the file and create a products list
  def createProductList([source: source, path: path]) do
    mock = findMock source
    data = YamlElixir.read_from_file path
    case [mock, data] do
      [{:ok, m}, {:ok, d}] -> 
        d |> 
        findData(m) |>
        Enum.map(fn f -> buildProduct f, m.fields end)
      [{:error, _}, _] -> Error.mockError source
      [_, {:error, _}] -> Error.invalidFile path
    end
  end
  
  # Find the source's mock
  def findMock(source) do
    f = Enum.find(@sourceStruct, fn %{source: src} -> src == source end)
    case f do
      nil -> {:error, "unknown source"}
      _ -> {:ok, f}
    end
  end

  # Find the products list in the raw data
  def findData(data, mock) do
    if Map.has_key?(mock, :data) do
      data[mock.data]
    else
      data
    end
  end

    # Fake product importation. In fact it only prints what it is supposed to do
  def importProduct(prod) do
    cats = Enum.join(prod.categories, ", ")
    IO.puts "importing: Name: #{prod.title}; Categories: #{cats}; Twitter: #{prod.twitter}"
  end
   
  # build the product struct
  def buildProduct(data, fields) do
    title = data[fields[:title].name]
    categories = getCategories(data, fields[:categories])
    case title do
      "" -> {:error, "Product name cannot be empty"}
      nil -> {:error, "Product may have a #{fields[:title].name} field"}
      _ -> {:ok, %Product{title: title, categories: categories, twitter: data[fields[:twitter].name]}}
    end
  end

  # Create a categories list from a list. It only gives the list back
  def getCategories(data, %{name: name, format: :list}) do
    data[name]
  end
  
  # Create a categories list from a string with the separator specified in the mock
  def getCategories(data, %{name: name, format: :string, separator: sep}) do
    String.split(data[name], sep) |> Enum.map(fn x -> String.trim x end)
  end
end
