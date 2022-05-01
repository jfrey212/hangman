require 'game.rb'

# load the dictionary method
def dictionary_load(file)
  File.open('dictionary.txt', 'r') do |file|
    dictionary = file.readlines
  end

  dictionary.map(&:chop!)
end
