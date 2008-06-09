class JboWord < ActiveRecord::Base

  belongs_to :jbo_type
  belongs_to :jbo_token

  has_many :parts, :class_name => 'JboPart'
  has_many :eng_words

  def to_xml( options = {} )
    options[:indent] ||= 2
    xml = options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])
    xml.instruct! unless options[:skip_instruct]

    xml.valsi :word => name, :type => jbo_type.name do
      xml.selmaho jbo.token.name  if jbo_token
      xml.definition defn  if defn
      xml.notes notes  if notes
      parts.each { |p|  xml.rafsi p.name }
    end
  end

end
