require 'rexml/document'

class ImportWords < ActiveRecord::Migration
  def self.up
    doc = nil
    say_with_time 'load wordlist (jbo/eng)'  do
      doc = REXML::Document.new File.open( File.join(RAILS_ROOT, 'public/data/lojban-en.xml') )
    end

    say_with_time "import lojban words"  do
      doc.elements.each 'dictionary/direction/valsi'  do |valsi|
        tags = []

        jbo_word = JboWord.new :name => valsi.attributes['word']
        jbo_word.defn = valsi.elements['definition'].text

        if %r{^\(?([0-9a-z -/]{5,43}):}i =~ jbo_word.defn
          tags << $1.downcase
        end

        tags << valsi.attributes['type']
        el = valsi.elements['selmaho']
        tags << el.text  if el

        el = valsi.elements['notes']
        jbo_word.notes = el.text  if el

        jbo_word.tag_list = tags.join(',')
        jbo_word.save!
        valsi.elements.each 'rafsi'  do |rafsi|
          part = JboPart.new :name => rafsi.text
          part.jbo_word = jbo_word
          part.save!
        end
      end
    end

    say_with_time "import english words"  do
      doc.elements.each 'dictionary/direction/nlword'  do |nlword|
        eng_word = EngWord.find_or_initialize_by_name nlword.attributes['word']
        eng_word.jbo_word = JboWord.find_by_name nlword.attributes['valsi']
        eng_word.save!
      end
    end
  end

  def self.down
    execute 'DELETE FROM jbo_words'
#    execute 'DELETE FROM jbo_related'
    execute 'DELETE FROM jbo_parts'
    execute 'DELETE FROM jbo_tokens'
    execute 'DELETE FROM jbo_types'
    execute 'DELETE FROM eng_words'
  end
end
