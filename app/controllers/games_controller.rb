require 'json'
require "open-uri"

class GamesController < ApplicationController
  def new
    # display a new random grid and
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    # form will be submitted (with POST) to the score action.
    # The word can’t be built out of the original grid
    # @letters.include? @new_word
    @input_letter = params[:new_word]
    if @new_word.english_word?
      "Congratulations! #{@new_word} is a valid English word!"
    else
      "Sorry but #{@new_word} is not a valid English word..."
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
