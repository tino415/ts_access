defmodule TsAccess.LensesTest do
  use ExUnit.Case

  describe "typedstruct" do
    defmodule Example do
      use TypedStruct
      use TsAccess.Lenses

      typedstruct do
        field(:name, :string)
        field(:online?, boolean())
      end
    end

    test "containing all functions" do
      example = %Example{name: "John", online?: true}

      assert "John" == get_in(example, [Example.name_lens()])
      assert get_in(example, [apply(Example, :"online?_lens", [])])
    end
  end
end
