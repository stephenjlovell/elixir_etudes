defmodule Geom do
  @moduledoc """
  This is the first module I ever wrote in Elixir.
  """

  @doc """
    This function calculates the area of the specified shape.
  """
  def area(:rectangle, height, width) when height > 0 and width > 0 do
    height * width
  end

  def area(:triangle, height, width) when height > 0 and width > 0 do
    (height * width) / 2.0
  end

  def area(:ellipse, major_radius, minor_radius) when major_radius > 0 and minor_radius > 0  do
    :math.pi() * major_radius * minor_radius
  end

end
