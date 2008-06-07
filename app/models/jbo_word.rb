class JboWord < ActiveRecord::Base

  belongs_to :jbo_type
  belongs_to :token, :class_name => 'JboToken'

  has_many :parts, :class_name => 'JboPart'
  has_many :en_words

end