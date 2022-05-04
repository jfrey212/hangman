# frozen_string_literal: true

# Game class stores state of the hangman game
class Game
  def initialize(word)
    @name = ''
    @word = word
    @count = 7
    @wrong_guesses = []
    @progress = Array.new(word.length, '_')
    @gameover = false
  end

  attr_accessor :wrong_guesses, :name, :count, :progress, :word, :gameover

  def update_progress(guess)
    if @word.include?(guess)
      @progress.each.with_index do |char, i|
        if guess == @word[i]
          @progress[i] = guess
        else
          next
        end
      end
    else
      @count -= 1
      @wrong_guesses << guess unless @wrong_guesses.include?(guess)
    end

    if @count.zero? || @progress.join == @word
      @gameover = true
    end
  end

  def save_game; end

end
