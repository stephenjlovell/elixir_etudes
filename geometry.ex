defmodule Geom do
  @moduledoc """
  This is the first module I ever wrote in Elixir.
  """

  @doc """
    This function calculates the area of the specified shape.
  """
  def area({shape, dim1, dim2}) do
    area(shape, dim1, dim2)
  end

  defp area(:rectangle, height, width) when height > 0 and width > 0 do
    height * width
  end

  defp area(:triangle, height, width) when height > 0 and width > 0 do
    (height * width) / 2.0
  end

  defp area(:ellipse, major_radius, minor_radius) when major_radius > 0 and minor_radius > 0  do
    :math.pi() * major_radius * minor_radius
  end

  defp area(_, _, _), do: 0  # example purposes only.  You'd really want to raise an exception.

end
