defmodule TsAccess.SettersTest do
  use ExUnit.Case

  describe "typedstruct" do
    defmodule Example do
      use TypedStruct
      use TsAccess.Setters

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

  describe "defsetter" do
    defmodule Example2 do
      require TsAccess.Setters

      defstruct [:name]

      TsAccess.Setters.defsetter(:name)
    end

    test "generated setter" do
      assert %Example2{name: "doe"} == Example2.name(%Example2{}, "doe")
    end
  end
end
