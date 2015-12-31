defmodule Dates do

  @doc """
    date_part(str) reads an ISO date string ("yyyy-mm-dd") and converts it to a list of numbers
  """
  @spec date_part(String.t()) :: list()
  def date_part(str) do
    Enum.map(String.split(str,"-"), fn s -> String.to_integer(s) end)
  end
end
