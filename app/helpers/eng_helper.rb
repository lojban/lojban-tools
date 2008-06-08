module EngHelper

  def jbo_word_column( word )
    link_to word.jbo_word.name, :controller => 'jbo', :action => 'show', :word => word.jbo_word.name
  end

end
