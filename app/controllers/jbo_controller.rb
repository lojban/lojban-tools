class JboController < ApplicationController

  before_filter :lookup_word, :only => [:show]

  active_scaffold :jbo_word  do |config|
    config.label = "Lojban Words"
#    config.actions.exclude :create, :update, :delete
    config.columns = [ 'name', 'defn', 'eng_words', 'parts', 'notes', 'tag_list' ]
    config.list.per_page = 25

    config.columns[:parts].search_sql = 'jbo_parts.name'
    config.search.columns = [ :name, :parts ]

    columns[:name].label = 'Word'
    columns[:defn].label = 'Definition'
    columns[:eng_words].label = 'English'
    columns[:parts].label = 'Parts'
    columns[:tag_list].label = 'Tags'
  end

  def main
    render :template => 'jbo/main', :layout => false
  end

  def tag
    @words = JboWord.find_tagged_with( params[:id], :on => :tags )
    render :template => 'jbo/tag', :layout => false
  end

protected

  def lookup_word
    if params[:word]
      word = JboWord.find_by_name(params[:word])
      unless word
        word = EngWord.find_by_name(params[:word])
        word = word.jbo_word  if word
      end
      params[:id] = word
    end
  end

  def self.active_scaffold_controller_for( klass )
    return  EngController if klass == EngWord
    super
  end

end
