# frozen_string_literal: true

# Game class stores state of the hangman game
class Game
  def initialize(name, word)
    @name = name
    @word = word
    @guess_count = 0
    @wrong_letters = []
    @word_progress = {}
  end

  attr_reader :name, :word
end
