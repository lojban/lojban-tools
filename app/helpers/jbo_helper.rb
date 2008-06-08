module JboHelper

  def defn_column( word )
    word.defn.gsub %r{\$?(\w)_\{?(\d)\}?\$?}, '<span class="sumti">\1<sub>\2</sub></span>'
  end

  def notes_column( word )
    return nil  unless word.notes
    notes = word.notes
    notes.gsub! %r{\$?(\w)_\{?(\d)\}?\$?}, '<span class="sumti">\1<sub>\2</sub></span>'
    notes.gsub!( %r{\{([\w'.,]+)\}} ) {  link_to( h($1), :controller => 'jbo', :action => 'show', :id => nil, :word => h($1) ) }
    notes
  end

end
