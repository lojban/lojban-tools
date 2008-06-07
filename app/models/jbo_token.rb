class JboToken < ActiveRecord::Base

  has_many :words, :class_name => 'JboWord'

end