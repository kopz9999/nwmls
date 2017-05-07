class Nwmls::ImageBinary
  include Nwmls::Model

  def self.attribute_names
    attrs = %w[ImageId ImageOrder UploadDt BLOB]
    if expand_attributes?
      attrs = attrs.collect { |attr| attr.underscore }
    end
    attrs.collect { |attr| attr.to_sym }
  end

  attr_accessor(*attribute_names)

  def self.find(conditions = {})
    unless conditions.is_a?(Hash)
      conditions = { :listing_number => conditions.to_i }
    end
    xml = Evernet::Connection.retrieve_image_binary(conditions)
    document =
      Nokogiri::XML::Builder.new do |x|
        x.root do
          xml.at('Images').children.each do |element|
            x.send('insert', element.serialize(save_with:0).sub("\n",""))
          end
        end
      end
    collection = build_collection(document.doc)
    if conditions[:id]
      collection.first
    else
      collection
    end
  end
end
