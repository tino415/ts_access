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

  describe "defgetter" do
    defmodule Example2 do
      require TsAccess.Getters

      defstruct [:name]

      TsAccess.Getters.defgetter(:name)
    end

    test "getter generateod" do
      assert "test" == Example2.name(%Example2{name: "test"})
    end
  end
end
