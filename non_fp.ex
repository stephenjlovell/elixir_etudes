defmodule NonFP do

  @spec generate_pockets([String.t]) :: [[number]]
  def generate_pockets(teeth_present) do
    :random.seed(:os.system_time())
    generate_pockets(teeth_present, :random.uniform())
  end

  @doc """
  This function has a character list consisting of T and F for its first argument.
  A T in the list indicates that the tooth is present, and a F indicates a missing tooth.
  The second argument is a floating point number between 0 and 1.0 that indicates the probability
  that a tooth will be a good tooth.
  The result is a list of lists, one list per tooth. If a tooth is present, the sublist has six entries;
  if a tooth is absent, the sublist is [0].
  """
  @spec generate_pockets([String.t], number) :: [[number]]
  def generate_pockets(teeth_present, probability) do
    generate_pockets(teeth_present, probability, [])
  end

  defp generate_pockets([], _probability, teeth), do: Enum.reverse(teeth)

  defp generate_pockets([tooth | teeth_present], probability, teeth) do
    generate_pockets(teeth_present, probability, [ generate_tooth(tooth, probability) | teeth] )
  end


  defp generate_tooth(tooth_present, _probability) when tooth_present == ?F, do: [0]

  defp generate_tooth(_tooth_present, probability) do
    generate_tooth_stats(probability, [], 0)
  end

  defp generate_tooth_stats(_probability, tooth, length) when length == 6, do: tooth

  defp generate_tooth_stats(probability, tooth, length) do
    max_depth = if :random.uniform() < probability, do: 3, else: 4
    depth = :random.uniform(max_depth)
    generate_tooth_stats(probability, [depth | tooth], length+1)
  end

end
