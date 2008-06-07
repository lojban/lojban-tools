class JboType < ActiveRecord::Base

  has_many :words, :class_name => 'JboWord'

end