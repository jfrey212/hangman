# frozen_string_literal: true

require './game'
require 'tty-prompt'

# Load the dictionary and select words between 5 and 12 characters
# The resulting array of words contains 7558 words
def dictionary_load
  File.open('dictionary.txt', 'r', &:readlines).map(&:chomp!).select { |word| word.length >= 5 && word.length <= 12 }
end

puts 'Welcome to Hangman!'

word_list = dictionary_load

# main game loop
loop do
  prompt = TTY::Prompt.new
  selection = prompt.select('Choose a game option:', ['New Game', 'Saved Game', 'Quit'])

  if selection == 'New Game'
    game = Game.new(prompt.ask('Enter Player Name'), word_list[rand(7559)])
    puts game.word
    puts game.name
  elsif selection == 'Saved Game'
    puts 'You chose saved game'
  elsif selection == 'Quit'
    puts 'Goodbye!'
    sleep(1)
    break
  else
    puts 'ERROR'
  end
end
