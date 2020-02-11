defmodule TsAccess.SettersTest do
    use ExUnit.Case
  
    defmodule Example do
      use TypedStruct
  
      @before_compile TsAccess.Setters
  
      typedstruct do
        field(:name, :string)
        field(:online?, :boolean)
      end
    end
  
    test "test containing all functions" do
      example = 
        %Example{}
        |> Example.name("John")
        |> Example.online?(true)
  
      assert %Example{
        name: "John",
        online?: true
      } == example
    end
  end
    