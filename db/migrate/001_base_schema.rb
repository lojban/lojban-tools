class BaseSchema < ActiveRecord::Migration
  def self.up
    # a.k.a. cmavo, gismu, and lujvo
    create_table :jbo_words  do |t|
      t.string :word, :null => false
      t.string :defn, :null => false
      t.string :notes

      t.references :jbo_type, :null => false
      t.references :jbo_token

      t.timestamps
    end
    add_index :jbo_words, :word

    # a.k.a. rafsi
    create_table :jbo_parts  do |t|
      t.string :word
      t.references :jbo_word, :null => false
    end
    add_index :jbo_parts, :word
    add_index :jbo_parts, :jbo_word_id

    create_table :jbo_types  do |t|
      t.string :name, :null => false
    end

    # for cmavo
    create_table :jbo_tokens  do |t|
      t.string :token, :null => false
    end

    create_table :en_words  do |t|
      t.string :word, :null => false
      t.references :jbo_word, :null => false
    end
    add_index :en_words, :word
    add_index :en_words, :jbo_word_id
  end

  def self.down
    drop_table :jbo_words
    drop_table :jbo_parts
    drop_table :jbo_tokens
    drop_table :jbo_types
    drop_table :en_words
  end
end
