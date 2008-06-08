class JboWord < ActiveRecord::Base

  belongs_to :jbo_type
  belongs_to :jbo_token

  has_many :parts, :class_name => 'JboPart'
  has_many :eng_words

end
