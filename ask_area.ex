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
    try do
      dim = String.to_integer(String.strip(IO.gets("Enter #{name}: ")))
      if dim <= 0 do
        try_again("#{name} must be a number greater than zero.", name)
      else
        dim
      end
    rescue
      ArgumentError -> try_again("Invalid entry (must be numeric)", name)
    end
  end

  defp try_again(msg, name) do
    IO.puts(msg)
    get_dimension(name)
  end

end
