defmodule TsAccess.GettersTest do
  use ExUnit.Case

  defmodule Example do
    use TypedStruct

    @before_compile TsAccess.Getters

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
