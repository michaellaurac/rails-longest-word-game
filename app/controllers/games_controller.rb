require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
  end

  def score
    @guess = params[:guess].upcase.split('')
    @letters = params[:letters].split(' ')
    @is_valid_build = valid_build?(@guess, @letters)
    @is_valid_english =valid_english?(@guess)
    @score = @is_valid_build && @is_valid_english ? @guess.length * @guess.length : 0
    session[:score] += @score
    return @score
  end

  def valid_build?(word, letters)
    list = letters.sort
    word.sort.each do |character|
      index = list.find_index(character)
      if index.nil? then return false
      elsif index == list.length - 1 then list = []
      else
        list = list[(index + 1)..(list.length - 1)]
      end
    end
    return true
  end

  def valid_english?(word)
    api_url = "https://wagon-dictionary.herokuapp.com/#{word.join('').downcase}"
    return JSON.parse(open(api_url).read)["found"]
  end
end
