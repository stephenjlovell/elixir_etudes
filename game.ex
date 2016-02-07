defmodule Game do

  @vsn 1.0
  require Player

  def start(num_players) do
    deck = Cards.make_deck() |> Cards.shuffle() |> add_values()
    # chunking may burn a card or two, but each player will have the same number
    # of cards to start.
    hands = Enum.chunk(deck, round(52/num_players))
    players = spawn_players(hands, [])
    play_game(players, 1)
  end

  # spawns num_players Player processes and returns a list of PIDs
  defp spawn_players([], players), do: players
  defp spawn_players([h|hands], players) do
    player = Player.start(h, self())
    spawn_players(hands, [player|players])
  end

  defp play_game(players, round) do
    IO.puts("round #{round}")
    # Make sure players are ready to participate in this round.
    for p <- players, do: send(p, :ready_up)
    players = get_players([], Enum.count(players))
    # The game ends when only one player is left.
    unless Enum.count(players) == 1 do
      play_round(players, [], 1)
      play_game(players, round+1)
    else
      IO.puts("player #{inspect hd(players)} wins!" )
    end
  end

  defp get_players(players, 0), do: players
  defp get_players(players, num_players) do
    receive do
      {:ok, cards, player} ->
        IO.puts("player #{inspect player} has #{cards} cards")
        get_players([player|players], num_players-1)
      {:forfeit, player} ->
        IO.puts("player #{inspect player} forfeits")
        get_players(players, num_players-1)
    end
  end


  defp play_round(players, pot, num_cards) do
    played = get_cards(players, num_cards)
    {new_players, flop} = evaluate(played)
    if Enum.count(new_players) == 1 do
      send(hd(new_players), {:take_cards, pot ++ flop})
    else
      IO.puts(" ---- It's a war! ----")
      play_round(new_players, pot ++ flop, 3)
    end
  end


  # Gather up the cards from this flop and determine the player(s) with the highest hand.
  defp evaluate(played) do
    max = Stats.maximum(for {[{_f, _s, val}|_tl], _p} <- played, do: val)
    evaluate(played, max, [], [])
  end

  defp evaluate([], _max, players, pot), do: {players, pot}
  defp evaluate([{cards, player}|tl], max, players, pot) do
    {_f, _s, val} = hd(cards)
    if val == max do
      evaluate(tl, max, [player|players], pot ++ cards)
    else
      evaluate(tl, max, players, pot ++ cards)
    end
  end

  def get_cards(players, num_cards) do
    for player <- players, do: send(player, {:give_cards, num_cards})
    receive_cards(Enum.count(players))
  end

  # receives cards sent by each player and determines the winner of the
  # current flop.
  defp receive_cards(num_players), do: receive_cards(num_players, [])
  defp receive_cards(0, played), do: played
  defp receive_cards(num_players, played) do
    receive do
      {:forfeit, _player} ->
        IO.puts("Player forfeits round.")
        receive_cards(num_players-1, played)
      {:take_cards, cards, player} ->
        receive_cards(num_players-1, [{cards, player}|played])
    end
  end

  @doc """
  takes list of tuples representing a deck of cards and appends the value of each card
  according to the card game War.
  """
  @spec add_values([tuple()]) :: [tuple()]
  def add_values(cards) do
    for {face, suit} <- cards, do: {face, suit, card_value({face, suit})}
  end

  @doc "determines the value of the given card."
  @spec card_value(tuple()) :: number()
  def card_value({face, _suit}) do
    case face do
      "J" -> 11
      "Q" -> 12
      "K" -> 13
      "A" -> 14
      _   -> face
    end
  end

end
