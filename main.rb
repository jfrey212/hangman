# frozen_string_literal: true

require 'game'

# load the dictionary method
def dictionary_load
  File.open('dictionary.txt', 'r', &:readlines).map(&:chomp!)
end
