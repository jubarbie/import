defmodule ProductTest do
  use ExUnit.Case

  test "building valid product" do
    fields = [title: %{name: "name", required: true}, categories: %{name: "tags", format: :string, separator: ","}, twitter: %{name: "twitter"}]
    data = %{"name" => "TestName", "tags" => "cat1, cat2", "twitter" => "@test"}
    expected = %Product{title: "TestName", categories: ["cat1", "cat2"], twitter: "@test"}
    assert Product.buildProduct(data, fields) == {:ok, expected}
  end
  
  test "building invalid product (no name)" do
    fields = [title: %{name: "name", required: true}, categories: %{name: "tags", format: :string, separator: ","}, twitter: %{name: "twitter"}]
    data = %{"tags" => "cat1, cat2", "twitter" => "@test"}
    {res, _} = Product.buildProduct(data, fields)
    assert res == :error
  end

  test "find existing source mock" do
    {result, _} = Product.findMock("capterra")
    assert result == :ok
  end
  
end
