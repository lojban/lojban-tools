class JboWord < ActiveRecord::Base

  belongs_to :jbo_type
  belongs_to :jbo_token

  has_and_belongs_to_many :related, :class_name => 'JboWord', :join_table => 'jbo_related', :foreign_key => 'word1_id', :association_foreign_key => 'word2_id'

  has_many :parts, :class_name => 'JboPart'
  has_many :eng_words

end
