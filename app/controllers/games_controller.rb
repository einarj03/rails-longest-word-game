require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    # raise
    @word = params[:word].upcase
    @letters = params[:letters].split
    @output = ''
    @word.split('').uniq.each do |uniq_letter|
      word_count = @word.split('').count { |letter| letter == uniq_letter }
      grid_count = @letters.count { |letter| letter == uniq_letter }
      if word_count > grid_count
        @error = 'grid_error'
        break
      end
    end
    return unless @error.nil?

    base_url = 'https://wagon-dictionary.herokuapp.com/'
    url = "#{base_url}#{@word}"
    word_serialized = open(url).read
    word_data = JSON.parse(word_serialized)
    if word_data['found']
      @new_score = word_data['length']**2
      session[:score] = session[:score].nil? ? new_score : session[:score] + @new_score
    else
      @error = 'invalid_word'
    end
    # end
  end

  def reset_score
    session[:score] = 0
    redirect_to new_path
  end
end
