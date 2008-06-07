require 'rexml/document'

class ImportWords < ActiveRecord::Migration
  def self.up
    doc = nil
    say_with_time 'load wordlist (jbo/en)'  do
      doc = REXML::Document.new File.open( File.join(RAILS_ROOT, 'public/data/lojban-en.xml') )
    end

    say_with_time "import jbo words"  do
      doc.elements.each 'dictionary/direction/valsi'  do |valsi|
        jbo_word = JboWord.find_or_initialize_by_word valsi.attributes['word']
        jbo_word.defn = valsi.elements['definition'].text
        jbo_word.jbo_type = JboType.find_or_create_by_name valsi.attributes['type']

        el = valsi.elements['notes']
        jbo_word.notes = el.text  if el

        el = valsi.elements['selmaho']
        jbo_word.token = JboToken.find_or_create_by_token el.text  if el

        jbo_word.save!
        valsi.elements.each 'rafsi'  do |rafsi|
          part = JboPart.find_or_initialize_by_word rafsi.text
          part.jbo_word = jbo_word
          part.save!
        end
      end
    end

    say_with_time "import en words"  do
      doc.elements.each 'dictionary/direction/nlword'  do |nlword|
        en_word = EnWord.find_or_initialize_by_word nlword.attributes['word']
        en_word.jbo_word = JboWord.find_by_word nlword.attributes['valsi']
        en_word.save!
      end
    end
  end

  def self.down
  end
end
