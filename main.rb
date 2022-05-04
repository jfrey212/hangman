# frozen_string_literal: true

require './game'
require 'tty-prompt'

# Load the dictionary and select words between 5 and 12 characters
# The resulting array of words contains 7558 words
def dictionary_load
  File.open('dictionary.txt', 'r', &:readlines).map(&:chomp!).select { |word| word.length >= 5 && word.length <= 12 }
end

def saves_load; end

def print_hangman(guess)
  puts "|-----#{guess.zero? ? '|' : '-'}"
  puts "|     #{'|' if guess.zero?}"
  puts "|     #{'O' if guess <= 6}"
  puts "|   #{'  ' if guess > 2}#{'--' if guess <= 2}#{'|' if guess <= 5}#{'--' if guess <= 1}"
  puts "|     #{'|' if guess <= 5}"
  puts "|    #{'/' if guess <= 4} #{'\\' if guess <= 3}"
  puts '|'
  puts '|___________'
end

def print_status(guessed_letters, guesses_left, word_progress)
  word_progress.each { |letter| print "#{letter} " }
  puts
  puts "Guesses Remaining: #{guesses_left}"
  print 'Missed Letters: '
  puts
  guessed_letters.each { |letter| print "#{letter} " }
  puts
end

def game_loop(game, prompt)
  loop do
    print_hangman(game.count)
    puts
    print_status(game.wrong_guesses, game.count, game.progress)
    puts

    if game.gameover
      if game.progress.join('') == game.word
        puts "\n\nYou won the game!"
        prompt.keypress('Press any key to return to main menu')
        break
      else
        puts "\n\nYou lost the game!"
        prompt.keypress('Press any key to return to main menu')
        break
      end
    end

    choice = prompt.select('Choose', %w( Guess Save Quit))

    case choice
    when 'Guess'
      char = prompt.ask('Guess a letter: ') do |q|
        q.modify :down
        q.validate(/[a-z]/)
      end
      game.update_progress(char)
      system('clear')
    when 'Save'
      game.name = prompt.ask('Enter a name for this saved game')
      break
    when 'Quit'
      break
    end
  end
end

word_list = dictionary_load
prompt = TTY::Prompt.new

# main game loop
loop do
  system('clear')
  puts "Welcome to Hangman!\n\n"
  selection = prompt.select('Choose a game option:', ['New Game', 'Saved Game', 'Quit'])

  case selection
  when 'New Game'
    system('clear')
    game = Game.new(word_list[rand(word_list.length + 1)])
    game_loop(game, prompt)
  when 'Load a Game'
    puts 'You chose saved game'
  when 'Quit'
    puts 'Goodbye'
    sleep(1)
    break
  end
end
