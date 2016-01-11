defmodule ListComp do

  def test_list_comp do
    list = [{"Federico", "M", 22}, {"Kim", "F", 45}, {"Hansa", "F", 30},
            {"Tran", "M", 47}, {"Cathy", "F", 32}, {"Elias", "M", 50}]
    list_comp(list)
  end

  @doc """
  reads in a list of tuples representing people and returns all individuals who are
  over age 40 OR who are male.
  """
  @spec list_comp(list(tuple)) :: list # return list may be empty.
  def list_comp(list) do
    for {name, sex, age} <- list, age > 40 or sex == "M", do: {name, sex, age}
  end

end
