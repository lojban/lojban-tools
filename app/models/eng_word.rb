class EngWord < ActiveRecord::Base

  belongs_to :jbo_word

  def to_label()  "\"#{name}\""  end

end