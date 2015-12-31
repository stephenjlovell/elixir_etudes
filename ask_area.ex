defmodule AskArea do

  @doc """
    area() prompts the user for info about a shape, then calculates the area of the chosen shape.
  """
  def area() do
    {dim1, dim2} = case (shape = get_shape()) do
      :rectangle  -> get_dimensions("height", "width")
      :triangle   -> get_dimensions("height", "width")
      :ellipse    -> get_dimensions("major radius", "minor radius")
    end
    IO.puts("the area is #{Geom.area(shape, dim1, dim2)}")
  end

  @spec get_shape() :: atom()
  defp get_shape() do
    str = String.first(IO.gets("R)ectangle, T)riangle, or E)llipse: "))
    case String.upcase(str) do
      "R" -> :rectangle
      "T" -> :triangle
      "E" -> :ellipse
       _  ->
         IO.puts("Unknown shape #{str} (Enter R, T, or E).")
         get_shape()
    end
  end

  @spec get_dimensions(String.t(), String.t()) :: {number(), number()}
  defp get_dimensions(str1, str2) do
    { get_dimension(str1), get_dimension(str2) }
  end

  @spec get_dimension(String.t()) :: number()
  defp get_dimension(name) do
    str = String.strip(IO.gets("Enter #{name}: "))
    cond do
      Regex.match?(~r/^[0-9]+\.[0-9]+(e[0-9]+)?$/, str) -> String.to_float(str) # match floats with or without exponents.
      Regex.match?(~r/[0-9]+/, str) -> String.to_integer(str)
      true ->
        IO.puts("Invalid entry #{str} (must be numeric)")
        get_dimension(name) # instead of returning an error, give the user another chance.
    end
  end

end
