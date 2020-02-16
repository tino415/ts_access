defmodule Support.Example do
  @moduledoc """
  Example module for tests
  """
  use TypedStruct
  use TsAccess

  typedstruct do
    field(:name, :string)
    field(:age, :integer)
  end
end
