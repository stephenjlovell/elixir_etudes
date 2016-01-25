defmodule Game do

  @vsn 1.0
  require Player

  def play(num_players) do
    deck = Cards.make_deck() |> Cards.shuffle()
    players = spawn_players(Enum.chunk(deck, round(52/num_players)), [])
    play(players, [], 1)
  end

  # spawns num_players Player processes and returns a list of PIDs
  defp spawn_players([], players), do: players
  defp spawn_players([h|hands], players) do
    player = Player.start(h, self())
    spawn_players(hands, [player|players])
  end

  defp play(players, pot, num_cards) do
    {flop, in_play, remaining_players} = get_cards(players, num_cards)

    case evaluate(in_play) do
      {:war, current_players} ->
        IO.puts("It's a war!")
        play(current_players, flop ++ pot, 3)
      {:winning_hand, player} ->
        send(player, {:take_cards, flop ++ pot})
        play(remaining_players, [], 1)
      {:game_over, winner} ->
        IO.puts("Player has won the game!")
    end
  end

  def evaluate(in_play) do
    if Enum.count(in_play) == 1 do
      {player, _value} = hd(in_play)
      {:game_over, player}
    else
      max = Stats.maximum(for {_p,v} <- in_play, do: v)
      players = for {p,_v} <- in_play, fn {_p,v} -> v == max end, do: p
      if Enum.count(players) == 1 do
        {:winning_hand, hd(players)}
      else
        {:war, players}
      end
    end
  end

  def get_cards(players, num_cards) do
    for player <- players, do: send(player, {:give_cards, num_cards})
    receive_cards(Enum.count(players))
  end

  # receives cards sent by each player and determines the winner of the
  # current flop.
  defp receive_cards(num_players) do
    receive_cards(num_players, [], [])
  end

  defp receive_cards(0, pot, in_play) do
    { pot, in_play, (for {p,_v} <- in_play, do: p) }
  end

  defp receive_cards(num_players, pot, in_play) do
    receive do
      {:forfeit, player} ->
        receive_cards(num_players-1, pot, in_play)
      {:take_cards, cards, player} ->
        value = { player, card_value(hd(cards)) }
        receive_cards(num_players-1, cards ++ pot, [value|in_play])
    end
  end



  def card_value({value, _suit}) do
    case value do
      "J" -> 11
      "Q" -> 12
      "K" -> 13
      "A" -> 14
      _   -> value
    end
  end



end
