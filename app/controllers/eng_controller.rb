class EngController < ApplicationController

  before_filter :lookup_word, :only => [:show]

  active_scaffold :eng_word  do |config|
    config.label = "English Translations"
    config.list.per_page = 25

    columns[:name].label = 'English'
    columns[:jbo_word].label = 'Lojban'
  end

protected

  def lookup_word
    if params[:word]
      word = EngWord.find_by_name(params[:word])
      unless word
        jbo_word = JboWord.find_by_name(params[:word])
        word = jbo_word.eng_words.first
        unless word
          redirect_to :controller => 'jbo', :action => 'show', :word => params[:word]
        end
      end
      params[:id] = word
    end
  end

end
