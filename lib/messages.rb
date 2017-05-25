module Messages
  def welcome
    'Welcome to Battleship!'
  end

  def opening_prompt
    'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
  end

  def goodbye_message
    'Not sure why you decided to bother me then, jeez.'
  end

  def invalid_selection
    "You know that wasn't an option, why'd you pick it?"
  end

  def instructions
    """
    The object of Battleship is to try and sink all of the other player's ships before they sink all of your ships.
    First, the computer will place their ships on the board.
    They cannot wrap around the board and must be in a straight line vertically or horizontally.
    Then you will place your own ships, following the same rules.
    Next, you and the computer will take turns shooting at coordinates on the other's board.
    Once all of one player's ships have been sunk the game ends.
    The player with ships remaining is the winner and deserves much glory.
    """
  end

  def divider
    '=' * 10
  end

  def computer_placed_ships
    """
    I have laid out my ships on the grid.
    You now need to layout your two ships.
    The first is two units long and the
    second is three units long.
    The grid has A1 at the top left and D4 at the bottom right.
    """
  end

  def begin_message
    'All the ships have been placed! Let the slaughter begin!'
  end

  def player_win_message
    "You have won! Unsurprising, given your opponent was a fool!"
  end

  def computer_win_message
    "Hah! You must have been trying to lose! Such madness."
  end
end
