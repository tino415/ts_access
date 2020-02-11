defmodule TsAccess.GettersTest do
  use ExUnit.Case

  defmodule Example do
    use TypedStruct

    @before_compile TsAccess.Getters

    typedstruct do
      field(:name, :string)
      field(:online?, :boolean)
    end
  end

  test "test containing all functions" do
    example = %Example{name: "John", online?: true}

    assert "John" == Example.name(example)
    assert Example.online?(example)
  end
end
  