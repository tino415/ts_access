defmodule TsAccessTest do
  import Support.Example

  use ExUnit.Case

  doctest TsAccess

  test "getters" do
    assert "John Doe" == Example.name(%Example{name: "John Doe"})
  end
end
