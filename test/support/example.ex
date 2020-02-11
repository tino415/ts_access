defmodule Support.Example do
  @moduledoc """
  Example module for tests
  """
  @before_compile TsAccess
  use TypedStruct

  typedstruct do
    field(:name, :string)
    field(:age, :integer)
  end
end
