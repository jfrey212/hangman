class Game
  def initialize(player, word, guess_count)
    @player = player
    @word = word
    @guess_count = guess_count
    @wrong_letters = []
    @word_progress = {}
  end
end
