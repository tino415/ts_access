defmodule TsAccess.GettersTest do
  use ExUnit.Case

  describe "typedstruct" do
    defmodule Example do
      use TypedStruct
      use TsAccess.Getters

      typedstruct do
        field(:name, :string)
        field(:online?, :boolean)
        field(:overriden, :integer)
      end

      def overriden(_value) do
        true
      end
    end

    test "containing all functions" do
      example = %Example{name: "John", online?: true}

      assert "John" == Example.name(example)
      assert Example.online?(example)
    end

    test "overriden function" do
      assert Example.overriden(nil)
    end
  end

  describe "explicit" do
    defmodule Explicit do
      use TsAccess.Getters, explicit: true

      defstruct [:gettable, :ungettable]

      defgetter(:gettable)
    end

    test "only defined" do
      assert "test" == Explicit.gettable(%Explicit{gettable: "test"})

      assert_raise(
        UndefinedFunctionError,
        fn -> "test" == Explicit.ungettable(%Explicit{ungettable: "test"}) end
      )
    end
  end
end
