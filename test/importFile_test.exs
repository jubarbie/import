defmodule ImportFileTest do
  use ExUnit.Case
  doctest Import

  test "good file format" do
    assert ImportFile.getFormat({:path, "path/to/good.json"}) == {:ok, :json} 
  end
    
  test "wrong file format" do
    {result, _} = ImportFile.getFormat({:path, "path/to/good.psd"}) 
    assert result == :error
  end
  
  test "no file format" do
    {result, _} = ImportFile.getFormat({:path, "path/to/good"}) 
    assert result == :error 
  end

end
