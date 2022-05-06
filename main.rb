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
      else
        puts "\n\nYou lost the game!"
        puts "The word is #{game.word}"
      end
      prompt.keypress('Press any key to return to main menu')
      break
    end

    choice = prompt.select('Choose', %w[Guess Save Quit])

    case choice
    when 'Guess'
      char = prompt.ask('Guess a letter: ') do |q|
        q.modify :down
        q.validate(/^[a-z]{1}$/, 'Your guess must be one letter')
      end
      if game.wrong_guesses.include?(char)
        puts 'You already guessed that letter!'
        prompt.keypress('Press any key to continue')
      else
        game.update_progress(char)
      end
      system('clear')
    when 'Save'
      game.name = prompt.ask('Enter a name for this saved game')
      game.save_game
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
  selection = prompt.select('Choose a game option:', ['New Game', 'Load a Game', 'Quit'])

  case selection
  when 'New Game'
    system('clear')
    game = Game.new(word_list[rand(word_list.length + 1)])
    game_loop(game, prompt)
  when 'Load a Game'
    if Dir.entries('save').length <= 2
      puts 'No save files found'
      prompt.keypress('Press any key to return to main menu')
      next
    else
      save_files = Dir.entries('save').select { |file| file =~ /json/ }
      filename = prompt.select('Choose a saved game file', save_files)
      game = Game.new('')
      game.load_game("save/#{filename}")
      system('clear')
      game_loop(game, prompt)
    end
  when 'Quit'
    puts 'Goodbye'
    sleep(1)
    break
  end
end
