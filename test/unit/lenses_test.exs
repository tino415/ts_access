defmodule TsAccess.LensesTest do
  use ExUnit.Case

  describe "typedstruct" do
    defmodule Example do
      use TypedStruct
      use TsAccess.Lenses

      typedstruct do
        field(:name, :string)
        field(:online?, boolean(), default: true)
      end
    end

    test "containing all functions" do
      example = %Example{name: "John"}

      assert "John" == get_in(example, [Example.name_lens()])
      assert "John" == get_in(example, [Example.name()])
      assert get_in(example, [Example.online?])
    end
  end
end
