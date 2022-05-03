# frozen_string_literal: true

# Game class stores state of the hangman game
class Game
  def initialize
    @name = name
    @word = word
    @count = 7
    @guessed_letters = []
    @word_progress = Array.new(word.length, '_')
  end

  attr_accessor :count, :guessed_letters, :word_progress, :name, :word

  def check_guess(guess)

  end

  def check_end_game
    if count == 0 && @word_progress.join != @word
      return 'lose'
    elsif @word_progress.join == @word
      return 'win'
    end
  end

  def save_game;end

  def load_game;end
end
