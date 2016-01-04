defmodule Dates do

  @doc """
    reads an ISO date string ("yyyy-mm-dd") and converts it to a list of numbers
  """
  @spec date_part(String.t()) :: list()
  def date_part(str) do
    Enum.map(String.split(str,"-"), fn s -> String.to_integer(s) end)
  end

  @doc """
    reads an ISO date string ("yyyy-mm-dd") and converts it to a Julian date (1-365))
  """
  @spec julian(String.t) :: number
  def julian(str) do
    [y, m, d] = date_part(str)
    julian(y, m-1, d)
  end

  defp julian(_, 1, d), do: d+31

  defp julian(y, m, d) do
    julian(y, m-1, d+days_in_month(y, m))
  end

  defp days_in_month(y, m) do
    cond do
      m == 9 || m == 4 || m == 6 || m == 11
            -> 30
      2     -> if is_leap_year(y), do: 29, else: 28
      true  -> 31
    end
  end

  defp is_leap_year(y) do
    (rem(y,4) == 0 and rem(y,100) != 0) or (rem(y, 400) == 0)
  end

end
