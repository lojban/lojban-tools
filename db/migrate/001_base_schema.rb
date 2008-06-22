class BaseSchema < ActiveRecord::Migration
  def self.up
    # a.k.a. cmavo, gismu, and lujvo
    create_table :jbo_words  do |t|
      t.string :name, :null => false
      t.string :defn, :null => false
      t.string :notes
      t.timestamps
    end
    add_index :jbo_words, :name

    # a.k.a. rafsi
    create_table :jbo_parts  do |t|
      t.string :name
      t.references :jbo_word, :null => false
    end
    add_index :jbo_parts, :name
    add_index :jbo_parts, :jbo_word_id

    create_table :jbo_types  do |t|
      t.string :name, :null => false
    end

    create_table :eng_words  do |t|
      t.string :name, :null => false
      t.references :jbo_word, :null => false
    end
    add_index :eng_words, :name
    add_index :eng_words, :jbo_word_id
  end

  def self.down
    drop_table :jbo_words
    drop_table :jbo_parts
    drop_table :eng_words
  end
end
