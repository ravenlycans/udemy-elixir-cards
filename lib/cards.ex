defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a list of playing cards
  """
  def create_deck do
    cards = [
      "Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"
    ]
    suits = [
      "Spades", "Clubs", "Hearts", "Diamonds"
    ]

    for suit <- suits, card <- cards do
        "#{card} of #{suit}"
    end
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples
      iex> deck = Cards.create_deck()
      iex> {hand,deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Shuffles the `deck` in arguments and returns the shuffled deck.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines wheather a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Creates a deck, shuffles it and deals `hand_size` cards, plus the remaining cards in the deck.

  ## Examples

      iex> { hand, deck } = Cards.create_hand(5)
      iex> Enum.count(hand)
      5
      iex> Cards.contains?(deck, hand)
      false
  """
  def create_hand(hand_size) do

    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end
end
