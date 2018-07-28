defmodule ProductTest do
  use ExUnit.Case

  test "building valid product" do
    mock = [title: "name", categories: "tags", twitter: "twitter"]
    data = %{"name" => "TestName", "tags" => "cat1, cat2", "twitter" => "@test"}
    expected = %Product{title: "TestName", categories: "cat1, cat2", twitter: "@test"}
    assert Product.buildProduct(mock, data) == {:ok, expected}
  end
  
  test "building invalid product (no name)" do
    mock = [title: "name", categories: "tags", twitter: "twitter"]
    data = %{"tags" => "cat1, cat2", "twitter" => "@test"}
    {res, _} = Product.buildProduct(mock, data)
    assert res == :error
  end

  test "find existing source mock" do
    {result, _} = Product.findMock("capterra")
    assert result == :ok
  end
end
