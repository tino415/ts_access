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

  describe "explicit" do
    defmodule Explicit do
      use TsAccess.Setters, explicit: true

      defstruct [:settable, :unsettable]

      defsetter(:settable)
    end

    test "only defined" do
      assert %Explicit{settable: "doe"} == Explicit.settable(%Explicit{}, "doe")

      assert_raise(
        UndefinedFunctionError,
        fn -> %Explicit{unsettable: "doe"} == Explicit.unsettable(%Explicit{}, "doe") end
      )
    end
  end
end
