# frozen_string_literal: true

require 'json'

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
      @progress.each.with_index do |_char, i|
        next unless guess == @word[i]

        @progress[i] = guess
      end
    else
      @count -= 1
      @wrong_guesses << guess unless @wrong_guesses.include?(guess)
    end

    return unless @count.zero? || @progress.join == @word

    @gameover = true
  end

  def save_game
    save = {
      name: @name,
      word: @word,
      count: @count,
      wrong_guesses: @wrong_guesses,
      progress: @progress
    }.to_json
    filename = "save/#{@name}.json"
    File.open(filename, 'w') do |file|
      file.puts save
    end
  end

  def load_game(file)
    data = File.read(file)
    game_data = JSON.parse(data, { symbolize_names: true })
    @name = game_data[:name]
    @word = game_data[:word]
    @count = game_data[:count]
    @wrong_guesses = game_data[:wrong_guesses]
    @progress = game_data[:progress]
  end
end
