defmodule TsAccessTest do
  alias Support.Example

  use ExUnit.Case

  doctest TsAccess

  test "getters" do
    assert "John Doe" == Example.name(%Example{name: "John Doe"})
  end

  describe "explicit" do
    defmodule Example do
      use TsAccess, explicit: true

      defstruct [
        :accessor,
        :getter,
        :setter
      ]

      defaccessor(:accessor)
      defgetter(:getter)
      defsetter(:setter)
    end

    test "accessor" do
      assert "name" == Example.accessor(%Example{accessor: "name"})
      assert %Example{accessor: "name"} == Example.accessor(%Example{}, "name")
    end

    test "getter" do
      assert "value" == Example.getter(%Example{getter: "value"})

      assert_raise(
        UndefinedFunctionError,
        fn -> %Example{getter: "value"} == Example.getter(%Example{}, "value") end
      )
    end

    test "setter" do
      assert %Example{setter: "value"} == Example.setter(%Example{}, "value")

      assert_raise(
        UndefinedFunctionError,
        fn -> "value" == Example.setter(%Example{setter: "value"}) end
      )
    end
  end
end
