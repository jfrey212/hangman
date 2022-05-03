# frozen_string_literal: true

require './game'
require 'tty-prompt'

# Load the dictionary and select words between 5 and 12 characters
# The resulting array of words contains 7558 words
def dictionary_load
  File.open('dictionary.txt', 'r', &:readlines).map(&:chomp!).select { |word| word.length >= 5 && word.length <= 12 }
end

def print_hangman(guess)
  puts "|-----#{guess == 0 ? '|' : '-'}"
  puts "|     #{'|' if guess == 0}"
  puts "|     #{'O' if guess <= 6}"
  puts "|   #{'  ' if guess > 2}#{'--' if guess <= 2}#{'|' if guess <= 5}#{'--' if guess <= 1}"
  puts "|     #{'|' if guess <= 5}"
  puts "|    #{'/' if guess <= 4} #{'\\' if guess <= 3}"
  puts '|'
  puts '|___________'
end

def print_status(guessed_letters, guess_left, word_progress)
  word_progress.each { |letter| print "#{letter} "}
  puts
  puts "Guesses Remaining: #{guesses_left}"
  print 'Guessed Letters: '
  guessed_letters.each { |letter| print "#{letter} " }
  puts
end

puts 'Welcome to Hangman!'

word_list = dictionary_load

# main game loop
loop do
  prompt = TTY::Prompt.new
  selection = prompt.select('Choose a game option:', ['New Game', 'Saved Game', 'Quit'])

  case selection
  when 'New Game'
    game = Game.new(prompt.ask('Enter Game Name'), word_list[rand(word_list.length + 1)])
  when 'Saved Game'
    puts 'You chose saved game'
  when 'Quit'
    puts 'Goodbye'
    sleep(1)
    break
  end
end
