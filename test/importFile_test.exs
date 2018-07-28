defmodule ImportFileTest do
  use ExUnit.Case
  doctest Import

  test "good file format" do
    assert ImportFile.checkFormat({:path, "path/to/good.json"}) == {:ok,[path: "path/to/good.json", format: :json]} 
  end
    
  test "wrong file format" do
    assert ImportFile.checkFormat({:path, "path/to/good.psd"}) == {:nok,[path: "path/to/good.psd"]} 
  end
  
  test "no file format" do
    assert ImportFile.checkFormat({:path, "path/to/good"}) == {:nok,[path: "path/to/good"]} 
  end

end
