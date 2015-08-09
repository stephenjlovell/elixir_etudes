defmodule Geom do
  @moduledoc """
  This is the first module I ever wrote in Elixir.
  """

  @doc """
    This function calculates the area of a rectangle given its length and width.
  """
  @spec area(number(), number()) :: number()
  def area(h, w) do
    h * w
  end

end
