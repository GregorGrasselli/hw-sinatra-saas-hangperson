class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize word
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess l
    raise ArgumentError if l.nil?
    throw ArgumentError unless l.match(/[a-z]/i)
    l.downcase!
    return false if @guesses.include?(l) || @wrong_guesses.include?(l)
    if @word.include? l
      @guesses << l
    else
      @wrong_guesses << l
    end
  end

  def word_with_guesses
    regex_string = @guesses.empty? ? '.' : "[^#{@guesses}]"
    @word.gsub Regexp.new(regex_string, true), '-'
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end

end
