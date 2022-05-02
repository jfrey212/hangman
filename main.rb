# frozen_string_literal: true

require './game'
require 'tty-prompt'

# Load the dictionary and select words between 5 and 12 characters
# The resulting array of words contains 7558 words
def dictionary_load
  File.open('dictionary.txt', 'r', &:readlines).map(&:chomp!).select { |word| word.length >= 5 && word.length <= 12 }
end

def check_letter(letter, word_progress, word)

end

def print_hangman(guess_count)

end

def print_turn(word, guess_count, wrong_letters, word_progress)

end

puts 'Welcome to Hangman!'

word_list = dictionary_load

# main game loop
loop do
  prompt = TTY::Prompt.new
  selection = prompt.select('Choose a game option:', ['New Game', 'Saved Game', 'Quit'])

  case selection
  when 'New Game'
    game = Game.new(prompt.ask('Enter Player Name'), word_list[rand(word_list.length + 1)])
  when 'Saved Game'
    puts 'You chose saved game'
  when 'Quit'
    puts 'Goodbye'
    sleep(1)
    break
  end
end
