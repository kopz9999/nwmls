module Nwmls
  module Model
    mattr_accessor :attribute_mode

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def build_collection(xml)
        collection = []
        xml.root.children.each do |element|
          attributes = {}
          element.children.each do |child|
            key = expand_attributes? ? child.name.underscore : child.name
            attributes[key] = child.text
          end
          collection << new(attributes)
        end
        collection
      end

      def expand_attributes?
        Nwmls::Model.attribute_mode != :raw
      end
    end

    def initialize(params={})
      params.each do |attr, value|
        if self.respond_to? attr
          self.public_send("#{attr}=", value)
        else
          Rails.logger.warn("#{attr} not found on #{self.class.name}")
        end
      end
    end

  end
end
